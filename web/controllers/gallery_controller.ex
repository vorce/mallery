defmodule Mallery.GalleryController do
  use Mallery.Web, :controller
  import Ecto.Query
  alias Mallery.Image

  def index(conn, _params) do
    query = from i in Image,
      order_by: [desc: i.inserted_at],
      limit: 200

    images = query
    |> Repo.all

    render(conn, "index.html", [sender: "everyone", images: images])
  end

  def show(conn, %{"sender" => sender}) do
    query = from i in Image,
      where: i.sender == ^sender,
      order_by: [desc: i.inserted_at],
      limit: 150 # TODO what to set this to?

    images = query
    |> Repo.all

    render(conn, "index.html", [sender: sender, images: images])
  end
end