defmodule Points.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Points.Repo,
      # Start the Telemetry supervisor
      PointsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Points.PubSub},
      # Start the Endpoint (http/https)
      PointsWeb.Endpoint,
      # Start a worker by calling: Points.Worker.start_link(arg)
      # {Points.Worker, arg}
      Points.Pointer
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Points.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PointsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
