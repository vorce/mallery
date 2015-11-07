defmodule Mallery.Work.S3Upload do
  @behaviour Mallery.Work

  use Honeydew
  require Logger
  
  def init({_client, _bucket, _next} = state) do
    {:ok, state}
  end

  def process(%Mallery.Work.Item{} = item, {client, bucket, next}) do
    Logger.info("Uploading item: #{inspect(item)} to: #{bucket}")

    case File.exists?(item.file) do
      true ->
        Logger.info("Work item file exists, trying to upload...")
        image_data = File.read!(item.file)

        # TODO: Expire date?
        result = client.put_object(bucket, item.id, image_data,
          [{:content_type, item.content_type}, {:acl, :public_read},
          {:meta, [{"Content-Type", item.content_type}]}])

        Logger.info("Done uploading to s3. Result: #{inspect(result)}")

        region = client.config_root() # TODO callbacks for s3 client?
        |> Keyword.get(:s3)
        |> Keyword.get(:region)

        url = "https://s3-#{region}.amazonaws.com/#{bucket}/#{item.id}"
        next.cast(:url_pool,
            {:process, [%{item | url: url}]})
      false ->
        Logger.warn("File referred to by item does not exist! #{inspect(item)}")
    end
    :ok
  end
end