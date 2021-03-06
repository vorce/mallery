defmodule Mallery.GalleryApiView do
  use Mallery.Web, :view

  def render("index.json", %{images: images}) do
    %{gallery: render_many(images, Mallery.GalleryApiView, "image.json")}
  end

  def render("image.json", %{gallery_api: image}) do
    %{id: image.id,
      sender: image.sender,
      img_url: image.img_url,
      url_prefix: image.url_prefix,
      url: "#{image.url_prefix}#{image.img_url}",
      name: image.name,
      description: image.description}
  end
end