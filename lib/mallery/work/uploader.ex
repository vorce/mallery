defmodule Mallery.Work.Uploader do
  use Honeydew
  require Logger

  def init(state) do
    {:ok, state}
  end

  def upload(name, state) do
    Logger.info("Starting to upload: #{name} to ...")
    :ok
  end
end