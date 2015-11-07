defmodule Mallery.MailgunController do
  use Mallery.Web, :controller

  @image_content_types ["image/png", "image/jpg", "image/jpeg", "image/gif"]

  def email(conn, %{"sender" => sender, "attachment-0" => attachment0} = params) do
    IO.inspect(params)
    IO.inspect(attachment0)

    fetcher = Application.get_env(:mallery, :fetcher)
    raw_dir = Application.get_env(:mallery, :raw_dir)
    send_resp(conn, 200, "Received #{0} images")
  end

  def email(conn, params) do
    IO.inspect(params)

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