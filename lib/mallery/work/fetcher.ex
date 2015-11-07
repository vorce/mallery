defmodule Mallery.Work.Fetcher do
  use Honeydew
  require Logger

  def init(state) do
    {:ok, state}
  end

  def fetch(%Mallery.Work.Item{} = item, uploader) do
    target_file = "#{item.dir}/#{item.name}"
    Logger.info("Fetching #{inspect(%{url: item.url, to: target_file})}")

    opts = [basic_auth: {"api", "key-c0e297ad36c4892d6fe93c19c41844a0"}]
    %HTTPoison.Response{body: data, status_code: 200} = HTTPoison.get!(item.url, [], [hackney: opts])
    
    File.write!(target_file, data)

    Logger.info("Done with fetching #{target_file}")
    uploader.cast(:upload_pool, {:upload, [item]})
  end
end