defmodule Mallery.GalleryApiControllerTest do
  use Mallery.ConnCase

  @valid_attrs %{description: "some content", img_url: "some content", name: "some content", sender: "some content", url_prefix: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "GET images from global gallery" do
    prefix = "prefix"
    url = "url"
    img = %{sender: "sender", img_url: url, url_prefix: prefix, name: "name", description: "description"}
    
    struct(Mallery.Image, img) |> Mallery.Repo.insert

    conn = get(conn, "/api/gallery")

    assert length(json_response(conn, 200)["gallery"]) == 1
    assert json_response(conn, 200)["gallery"] |> hd |> Map.get("url") == prefix <> url
  end

  test "GET images from user gallery" do
    prefix = "prefix"
    url = "url"
    sender = "sender"
    img = %{sender: sender, img_url: url, url_prefix: prefix, name: "name", description: "description"}
    
    struct(Mallery.Image, img) |> Mallery.Repo.insert

    conn = get(conn, "/api/gallery/sender")

    assert length(json_response(conn, 200)["gallery"]) == 1
    assert json_response(conn, 200)["gallery"] |> hd |> Map.get("url") == prefix <> url
  end

  test "GET images from unknown user gallery gives 404" do
    conn = get(conn, "/api/gallery/foo")
    assert response(conn, 404)
  end
end
