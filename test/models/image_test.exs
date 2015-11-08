defmodule Mallery.ImageTest do
  use Mallery.ModelCase

  alias Mallery.Image

  @valid_attrs %{img_url: "some content", sender: "some content", url_prefix: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Image.changeset(%Image{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with valid attributes and optional ones" do
    changeset = Image.changeset(%Image{}, Map.merge(@valid_attrs, %{name: "foo", description: "bar"}))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Image.changeset(%Image{}, @invalid_attrs)
    refute changeset.valid?
  end
end
