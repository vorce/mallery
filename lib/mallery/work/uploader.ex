defmodule Mallery.Work.Uploader do
  use Honeydew
  require Logger

  def init(state) do
    {:ok, state}
  end

  def upload(%Mallery.Work.Item{} = item, state) do
    Logger.info("Starting to upload: #{item.name} to ...")
    :ok
  end
end