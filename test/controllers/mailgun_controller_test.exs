defmodule Mallery.MailgunControllerTest do
  use Mallery.ConnCase

  test "Post /mailgun/" do
    conn = post(conn(), "/mailgun", [username: "john", password: "doe"])
    assert response(conn, 202)
  end
end