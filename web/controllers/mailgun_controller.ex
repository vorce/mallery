defmodule Mallery.MailgunController do
  use Mallery.Web, :controller

  @image_content_types ["image/png", "image/jpg", "image/jpeg", "image/gif"]

  def email(conn, %{"Message-Id" => id, "sender" => sender, "attachments" => attachments} = _params) do
    fetcher = Application.get_env(:mallery, :fetcher)
    raw_dir = Application.get_env(:mallery, :raw_dir)

    case images(attachments) do
      [] ->
        send_resp(conn, 406, "No image attachments found")
      imgs ->
        imgs
        |> Enum.each(fn(img) ->
          fetcher.cast(:fetch_pool,
            {:fetch, [%{url: img["url"], dir: raw_dir, name: "#{id}_#{Map.get(img, "name")}"}]}) end)
  
        send_resp(conn, 200, "Received #{length(imgs)} images")
    end
  end

  def email(conn, _params) do
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