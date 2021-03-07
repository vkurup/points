defmodule Points.User do
  @moduledoc """
  Define the User schema and changeset.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :points, :integer

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:points])
    |> validate_required([:points])
  end
end
