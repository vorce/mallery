defmodule Mallery.ImageApiView do
  use Mallery.Web, :view

  def render("show.json", %{image: image}) do
    %{image: render_one(image, Mallery.ImageApiView, "image.json")}
  end

  def render("image.json", %{image_api: image}) do
    %{id: image.id,
      sender: image.sender,
      img_url: image.img_url,
      url_prefix: image.url_prefix,
      url: "#{image.url_prefix}#{image.img_url}",
      name: image.name,
      description: image.description}
  end
end