defmodule Mallery.Work do
  @doc "Processes a work item"
  @callback process(item :: %Mallery.Work.Item{}, state :: Any.t) :: Atom.t
end