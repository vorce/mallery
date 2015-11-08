defmodule Mallery.ImageApiController do
  use Mallery.Web, :controller
  alias Mallery.Image

  def show(conn, %{"id" => id}) do
    image = Repo.get!(Mallery.Image, id)
    render(conn, "image.json", image: image)
  end

  def delete(conn, %{"id" => id}) do
    image = Repo.get!(Image, id)

    Repo.delete!(image)

    send_resp(conn, :no_content, "")
  end

  def update(conn, %{"id" => id, "image" => image_params}) do
    image = Repo.get!(Mallery.Image, id)
    changeset = Mallery.Image.changeset(image, image_params)

    case Repo.update(changeset) do
      {:ok, image} ->
        render(conn, "image.json", image: image)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Mallery.ChangesetView, "error.json", changeset: changeset)
    end
  end
end