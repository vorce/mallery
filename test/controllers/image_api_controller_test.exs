defmodule Mallery.ImageApiControllerTest do
  use Mallery.ConnCase

  @valid_attrs %{description: "some content", img_url: "some content", name: "some content", sender: "some content", url_prefix: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "GET image by id" do
    image = Repo.insert!(%Mallery.Image{})
    conn = get(conn, "/api/image/#{image.id}")
    assert json_response(conn, 200)["image"] == %{"id" => image.id,
      "sender" => image.sender,
      "img_url" => image.img_url,
      "url_prefix" => image.url_prefix,
      "name" => image.name,
      "description" => image.description,
      "url" => "#{image.url_prefix}#{image.img_url}"}
  end

  test "throws error on unknown id", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get(conn, "/api/image/-1")
    end
  end

  test "DELETE image by id", %{conn: conn} do
    image = Repo.insert!(%Mallery.Image{})
    conn = delete(conn, "/api/image/#{image.id}")
    assert response(conn, 204)
    refute Repo.get(Mallery.Image, image.id)
  end

  test "PUT updates image when data is valid", %{conn: conn} do
    image = Repo.insert!(%Mallery.Image{})
    conn = put(conn, "/api/image/#{image.id}", image: @valid_attrs)
    assert json_response(conn, 200)["image"]["id"] == image.id
    assert Repo.get_by(Mallery.Image, @valid_attrs)
  end

  test "PUT does not update when data is invalid", %{conn: conn} do
    image = Repo.insert!(%Mallery.Image{})
    conn = put(conn, "/api/image/#{image.id}", image: @invalid_attrs)
    assert json_response(conn, 422)["errors"] != %{}
  end
end