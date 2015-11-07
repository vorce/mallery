defmodule Mallery.Work.ImageFetch do
  @behaviour Mallery.Work

  use Honeydew
  require Logger

  def init(state) do
    {:ok, state}
  end

  def fetch(%Mallery.Work.Item{} = item, worker) do
    target_file = "#{item.dir}/#{item.name}"
    Logger.info("Fetching #{inspect(%{url: item.url, to: target_file})}")

    opts = [basic_auth: {"api", "key-c0e297ad36c4892d6fe93c19c41844a0"}]
    %HTTPoison.Response{body: data, status_code: 200} = HTTPoison.get!(item.url, [], [hackney: opts])
    
    File.write!(target_file, data)

    Logger.info("Done with fetching #{target_file}")
    worker.cast(:persist_pool, {:process, [item]})
  end

  def process(%Mallery.Work.Item{} = item, worker) do
    fetch(item, worker)
  end
end