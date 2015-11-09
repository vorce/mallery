defmodule Mallery.Work.S3UploadTest do
  use ExUnit.Case
  alias Honeydew.WorkQueue
  alias Honeydew.Worker

  # TODO break out into helper module
  setup do
    {:ok, work_queue} = Mallery.Work.S3Upload
    |> Honeydew.work_queue_name(:test_pool)
    |> WorkQueue.start_link(3, 1)

    on_exit fn ->
      Process.exit(work_queue, :kill)
    end

    :ok
  end

  def queue_length, do: Mallery.Work.S3Upload.status(:test_pool)[:queue]

  def start_worker_linked do
    Worker.start_link(:test_pool, Mallery.Work.S3Upload, {Mallery.S3Mock, "bucket", Mallery.Work.Dummy}, 5)
  end

  test "gives error on non-existant file" do
    start_worker_linked()
    assert queue_length() == 0

    result = Mallery.Work.S3Upload.call(:test_pool,
      {:process, [%Mallery.Work.Item{file: "/foo/bar", id: "id", name: "name", content_type: "image/jpg", description: "n/a"}]})
    assert result |> elem(0) == :error
  end

  test "succeeds on file that exists" do
    start_worker_linked()
    assert queue_length() == 0

    result = Mallery.Work.S3Upload.call(:test_pool,
      {:process, [%Mallery.Work.Item{file: "mix.exs", id: "id", name: "name", content_type: "image/jpg", description: "n/a"}]})
    assert result == :ok
  end
end