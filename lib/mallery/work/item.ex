defmodule Mallery.Work.Item do
  @moduledoc """
  A piece of work to be carried out by Mallery
  """
  defstruct id: "", file: "", url: "",
    name: "", sender: "unknown", content_type: "", description: ""
end