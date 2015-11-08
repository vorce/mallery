defmodule Mallery.PageControllerTest do
  use Mallery.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Mallery"
  end
end
