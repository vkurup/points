defmodule Points.Pointer do
  @moduledoc """
  GenServer that randomly updates the points of all Users every minute and returns query results to clients.
  """
  use GenServer

  # Client API

  def start_link(_) do
    state = %{
      max_number: 0,
      timestamp: nil,
      users: []
    }

    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def query() do
    GenServer.call(__MODULE__, :query)
  end

  # Server

  @impl true
  def init(state) do
    # run a user update...
    send(self(), :update)
    # ... and schedule another update for every minute
    :timer.send_interval(60_000, :update)
    {:ok, state}
  end

  @impl true
  def handle_info(:update, state) do
    # update every user's points in the database (random 0-100)
    Points.update_user_points()
    # refresh the max_number with a new random number
    new_state = %{state | max_number: Enum.random(0..100)}
    {:noreply, new_state}
  end

  @impl true
  def handle_call(:query, _from, state) do
    # query DB for users with more points than state.max_number
    users = Points.list_users_with_more_points_than(state.max_number)
    # create new_state with an updated timestamp and users list
    new_state = %{state | timestamp: DateTime.utc_now() |> DateTime.to_string(), users: users}
    # return PREVIOUS state to client, then update state to new_state
    {:reply, state, new_state}
  end
end
