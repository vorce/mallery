defmodule Mallery.Work.S3Upload do
  @behaviour Mallery.Work

  use Honeydew
  require Logger
  
  def init({_client, _bucket, _next} = state) do
    {:ok, state}
  end

  def process(%Mallery.Work.Item{} = item, {client, bucket, next}) do
    Logger.info("Request for upload of item: #{inspect(item)} to: #{bucket}")

    case File.exists?(item.file) do
      true ->
        Logger.info("Work item file exists, trying to upload...")
        image_data = File.read!(item.file)

        upload(client, image_data, bucket, item)

        add_url_job(client.config_root(), bucket, item, next)
      false ->
        msg = "File referred to by item does not exist! #{inspect(item)}"
        Logger.error(msg)
        {:error, msg}
    end
  end

  defp upload(client, data, bucket, item) do
    # TODO: Expire date?
    result = client.put_object(bucket, item.id, data,
      [{:content_type, item.content_type}, {:acl, :public_read},
      {:meta, [{"Content-Type", item.content_type}]}])
    Logger.info("Done uploading to s3. Result: #{inspect(result)}")
  end

  defp add_url_job(config, bucket, item, next) do
    region = config
    |> Keyword.get(:s3)
    |> Keyword.get(:region)

    url = "https://s3-#{region}.amazonaws.com/#{bucket}/#{item.id}"
    next.cast(:url_pool,
            {:process, [%{item | url: url}]})
  end
end