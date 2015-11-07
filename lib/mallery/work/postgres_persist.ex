defmodule Mallery.Work.PostgresPersist do
  @behaviour Mallery.Work

  use Honeydew
  require Logger

  def init(prefix) do
    {:ok, prefix}
  end

  def persist(%Mallery.Work.Item{} = item, prefix) do
    Logger.info("Starting to persist: #{item.name} to postgres")

    params = %{sender: item.sender,
      url_prefix: prefix, img_url: item.url}
 
    changeset = Mallery.Image.changeset(%Mallery.Image{}, params)
    {:ok, _m} = Mallery.Repo.insert(changeset)

    Logger.info("Saved #{inspect(params)}")
    :ok
  end

  def process(%Mallery.Work.Item{} = item, state) do
    persist(item, state)
  end
end