defmodule Mallery.ImageApiView do
  use Mallery.Web, :view

  def render("image.json", %{image: image}) do
    %{id: image.id,
      sender: image.sender,
      img_url: image.img_url,
      url_prefix: image.url_prefix,
      url: "#{image.url_prefix}#{image.img_url}",
      name: image.name,
      description: image.description}
  end
end