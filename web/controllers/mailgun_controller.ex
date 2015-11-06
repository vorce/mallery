defmodule Mallery.MailgunController do
  use Mallery.Web, :controller

  require Logger

  @image_content_types ["image/png", "image/jpg", "image/jpeg", "image/gif"]

  def email(conn, %{"attachments" => attachments} = params) do
    Logger.debug("Incoming email request: #{inspect(params)}")

    case images(attachments) do
      [] ->
        send_resp(conn, 406, "No image attachments found")
      i ->
        send_resp(conn, 200, "Received #{length(i)} images")
    end
  end

  def email(conn, params) do
    Logger.debug("Incoming email request: #{inspect(params)}")

    conn
    |> send_resp(406, "No attachments found")
  end

  def images(attachments) do
    Poison.Parser.parse!(attachments)
      |> Enum.filter(&image_content_type?/1)
  end

  defp image_content_type?(%{"content-type" => content_type}) do
    @image_content_types
    |> Enum.into(HashSet.new)
    |> Set.member?(String.downcase(content_type))
  end

  defp image_content_type?(_in) do
    false
  end
end