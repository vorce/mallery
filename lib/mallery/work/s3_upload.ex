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
        result = client.put_object(bucket, item.name, image_data,
          [{:content_type, item.content_type}, {:acl, :public_read}])
        Logger.info("Done uploading to s3. Result: #{inspect(result)}")
        # TODO: delete item.file
      fase ->
        Logger.warn("Work item file does not exist! #{inspect(item)}")
    end
    :ok
  end
end