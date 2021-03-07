defmodule Points do
  @moduledoc """
  Points keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  import Ecto.Query, warn: false
  alias Points.Repo
  alias Points.User

  def list_users_with_more_points_than(points) do
    User
    |> where([u], u.points > ^points)
    |> limit(2)
    |> Repo.all()
  end

  def update_user_points() do
    User
    |> Repo.all()
    |> Enum.each(fn user ->
      changeset = User.changeset(user, %{points: Enum.random(0..100)})
      Repo.update(changeset)
    end)
  end
end
