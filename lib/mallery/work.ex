defmodule Mallery.Work do
  @doc "Processes a work item async"
  @callback process(item :: %Mallery.Work.Item{}, state :: Any.t) :: Atom.t
end