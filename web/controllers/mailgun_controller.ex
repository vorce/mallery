defmodule Mallery.MailgunController do
  use Mallery.Web, :controller

  @image_content_types ["image/png", "image/jpg", "image/jpeg", "image/gif"] # TODO more?

  def email(conn, %{"Message-Id" => id, "sender" => sender, "attachment-1" => attachment1} = params) do
    IO.inspect(params) # TODO remove
    IO.inspect(attachment1) # TODO remove

    worker = Application.get_env(:mallery, :uploader)

    attachments = params
    |> Map.drop(["attachment-count"])
    |> Enum.filter(fn({k, _}) -> String.starts_with?(k, "attachment-") end)

    case images(attachments) do
      [] ->
        send_resp(conn, 406, "No image attachments found")
      imgs ->
        imgs
        |> Enum.each(fn({_, %Plug.Upload{path: path, filename: name, content_type: type} = _v}) ->
          worker.cast(:upload_pool,
            {:process, [
              %Mallery.Work.Item{file: path,
                id: "#{clean_id(id)}_#{name}",
                name: name,
                sender: sender,
                content_type: type}]}) end)

        send_resp(conn, 200, "Received #{length(imgs)} images")
    end
  end

  def email(conn, params) do
    IO.inspect(params)

    conn
    |> send_resp(406, "No attachments found")
  end

  def images(attachments) do
    attachments
    |> Enum.filter(fn({_, %Plug.Upload{content_type: content}}) -> image_type?(content) end)
  end

  defp image_type?(content_type) do
    @image_content_types
    |> Enum.member?(String.downcase(content_type))
  end

  defp clean_id(id) do
    id
    |> String.replace("<", "")
    |> String.replace(">", "")
  end
end