defmodule PointsWeb.UserController do
  use PointsWeb, :controller
  alias Points.Pointer

  def index(conn, _params) do
    result =
      Pointer.query()
      |> Map.take([:users, :timestamp])

    json(conn, result)
  end
end
