defmodule Mallery.Work.RepoPersistTest do
  use ExUnit.Case
  alias Honeydew.WorkQueue
  alias Honeydew.Worker
  import Ecto.Query

  @moduletag :integration

  setup do
    {:ok, work_queue} = Mallery.Work.RepoPersist
    |> Honeydew.work_queue_name(:test_pool)
    |> WorkQueue.start_link(3, 1)

    on_exit fn ->
      Process.exit(work_queue, :kill)
    end

    :ok
  end

  def queue_length, do: Mallery.Work.RepoPersist.status(:test_pool)[:queue]

  def start_worker_linked do
    Worker.start_link(:test_pool, Mallery.Work.RepoPersist, "prefix", 5)
  end

  test "persists to repo" do
    start_worker_linked()
    assert queue_length() == 0

    sender = "test"
    Mallery.Work.RepoPersist.cast(:test_pool,
      {:process, [%Mallery.Work.Item{sender: sender, url: "http://foo.com"}]})
    
    assert queue_length() == 0

    query = from i in Mallery.Image,
      where: i.sender == ^sender,
      order_by: [desc: i.inserted_at],
      limit: 10

    assert length(query |> Mallery.Repo.all) == 1
  end
end