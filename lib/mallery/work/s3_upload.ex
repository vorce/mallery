defmodule Mallery.Work.S3Upload do
  @behaviour Mallery.Work

  use Honeydew
  require Logger
  
  def init({_client, _next} = state) do
    {:ok, state}
  end

  def process(%Mallery.Work.Item{} = item, {client, next}) do
    Logger.info("Uploading to s3: #{inspect(item)}")
    :ok
  end
end