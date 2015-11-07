defmodule Mallery.Work.S3Upload do
  @behaviour Mallery.Work

  use ExAws.S3.Client, otp_app: :s3_upload
  use Honeydew
  require Logger
  
  def init(state) do
    {:ok, state}
  end

  def process(%Mallery.Work.Item{} = item, state) do
    Logger.info("Uploading to s3: #{inspect(item)}")
    :ok
  end
end