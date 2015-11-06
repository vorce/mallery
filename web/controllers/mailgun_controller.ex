defmodule Mallery.MailgunController do
  use Mallery.Web, :controller

  require Logger

  def email(conn, params) do
    Logger.info("Incoming email request: #{inspect(params)}")

    conn
    |> send_resp(202, "")
  end
end