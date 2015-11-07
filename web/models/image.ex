defmodule Mallery.Image do
  use Mallery.Web, :model

  schema "images" do
    field :sender, :string
    field :img_url, :string
    field :url_prefix, :string

    timestamps
  end

  @required_fields ~w(sender img_url url_prefix)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
