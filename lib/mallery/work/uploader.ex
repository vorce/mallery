defmodule Mallery.Work.Uploader do
  @behaviour Mallery.Work

  use Honeydew
  require Logger

  def init(state) do
    {:ok, state}
  end

  def upload(%Mallery.Work.Item{} = item, _state) do
    Logger.info("Starting to upload: #{item.name} to ...")
    :ok
  end

  def process(%Mallery.Work.Item{} = item, state) do
    upload(item, state)
  end
end