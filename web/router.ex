defmodule Mallery.Router do
  use Mallery.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Mallery do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/gallery/", GalleryController, :index
    get "/gallery/:sender", GalleryController, :show

    resources "/images", ImageController
  end

  scope "/mailgun", Mallery do
    pipe_through :api

    post "/", MailgunController, :email
  end

  scope "/api", Mallery do
    pipe_through :api

    get "/gallery", GalleryApiController, :index
    get "/gallery/:sender", GalleryApiController, :show

    get "/image/:id", ImageApiController, :show
    delete "/image/:id", ImageApiController, :delete
    patch "/image/:id", ImageApiController, :update
    put "/image/:id", ImageApiController, :update
  end
end
