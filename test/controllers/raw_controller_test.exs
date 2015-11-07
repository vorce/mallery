defmodule Mallery.RawControllerTest do
  use Mallery.ConnCase

  test "GET existing raw image" do
    conn = get(conn(), "/raw/happy.png")

    assert response(conn, 200)
    assert response_content_type(conn, :png)
  end

  test "GET unknown raw image" do
    conn = get(conn(), "/raw/foo.png")
    assert response(conn, 404)
  end
end