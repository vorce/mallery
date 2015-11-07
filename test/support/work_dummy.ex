defmodule Mallery.Work.Dummy do
  @behaviour Mallery.Work

  use Honeydew

  def init(state) do
    {:ok, state}
  end

  def process(%Mallery.Work.Item{} = _, _) do
    :ok
  end
end