defmodule Mallery.RawControllerTest do
  use Mallery.ConnCase

  test "GET existing raw image" do
    conn = get(conn(), "happy.png")
    assert response(conn, 200)
  end

  test "GET unknown raw image" do
    conn = get(conn(), "foo.png")
    assert response(conn, 404)
  end
end