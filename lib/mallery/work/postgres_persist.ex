defmodule Mallery.Work.PostgresPersist do
  @behaviour Mallery.Work

  use Honeydew
  require Logger

  def init(state) do
    {:ok, state}
  end

  def persist(%Mallery.Work.Item{} = item, state) do
    Logger.info("Starting to persist: #{item.name} to postgres")
    _ = """
    params = %{}
 
    changeset = Mallery.Image.changeset(%Mallery.Image{}, params)
    {:ok, m} = Mallery.Repo.insert(changeset)
    """
    :ok
  end

  def process(%Mallery.Work.Item{} = item, state) do
    persist(item, state)
  end
end