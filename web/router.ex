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
    get "/gallery/:sender", GalleryController, :index

    resources "/images", ImageController
  end

  scope "/mailgun", Mallery do
    pipe_through :api

    post "/", MailgunController, :email
  end

  # Other scopes may use custom stacks.
  # scope "/api", Mallery do
  #   pipe_through :api
  # end
end
