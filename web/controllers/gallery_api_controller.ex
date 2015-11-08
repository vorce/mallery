defmodule Mallery.GalleryApiController do
  use Mallery.Web, :controller
  alias Mallery.Image

  def index(conn, _params) do
    query = from i in Image,
      order_by: [desc: i.inserted_at]

    images = query
    |> Mallery.Repo.all

    render(conn, "index.json", images: images)
  end

  def show(conn, %{"sender" => sender} = _params) do
    query = from i in Image,
      where: i.sender == ^sender,
      order_by: [desc: i.inserted_at]

    images = query
    |> Repo.all

    case images do
      [] -> send_resp(conn, 404, "")
      _ -> render(conn, "index.json", images: images)
    end
  end
end