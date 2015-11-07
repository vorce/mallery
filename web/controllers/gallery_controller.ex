defmodule Mallery.GalleryController do
  use Mallery.Web, :controller
  import Ecto.Query
  alias Mallery.Image

  def index(conn, %{"sender" => sender}) do
    query = from i in Image,
      where: i.sender == ^sender,
      order_by: [desc: i.inserted_at],
      limit: 1000

    images = query
    |> Repo.all

    render(conn, "index.html", [sender: sender, images: images])
  end
end