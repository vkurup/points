defmodule PointsWeb.UserControllerTest do
  use PointsWeb.ConnCase

  test "GET /", %{conn: conn} do
    # Smoke test. first response has expected "empty data"
    conn = get(conn, "/")
    body = json_response(conn, 200)
    assert body["users"] == []
    assert body["timestamp"] == nil

    # second response has an updated (parseable) timestamp
    conn = get(conn, "/")
    body = json_response(conn, 200)
    assert body["users"] == []
    assert DateTime.from_iso8601(body["timestamp"])
  end
end
