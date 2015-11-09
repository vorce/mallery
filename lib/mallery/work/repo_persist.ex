defmodule Mallery.Work.RepoPersist do
  @moduledoc """
  Saves work items to a Repo
  """

  @behaviour Mallery.Work

  use Honeydew
  require Logger

  def init(prefix) do
    {:ok, prefix}
  end

  def persist(%Mallery.Work.Item{} = item, prefix) do
    Logger.info("Starting to persist: #{item.name} to repo")

    params = %{sender: item.sender,
      url_prefix: prefix, img_url: item.url,
      name: item.name, description: item.description}
 
    changeset = Mallery.Image.changeset(%Mallery.Image{}, params)
    {:ok, _m} = Mallery.Repo.insert(changeset)

    Logger.info("Saved #{inspect(params)}")
    :ok
  end

  def process(%Mallery.Work.Item{} = item, state) do
    persist(item, state)
  end
end