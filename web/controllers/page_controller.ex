defmodule Mallery.PageController do
  use Mallery.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
