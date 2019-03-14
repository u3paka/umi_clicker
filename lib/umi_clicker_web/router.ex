defmodule UmiClickerWeb.Router do
  use UmiClickerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", UmiClickerWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/datastore/dump", DataStoreController, :dump
    post "/datastore/restore", DataStoreController, :restore
  end

  # Other scopes may use custom stacks.
  # scope "/api", UmiClickerWeb do
  #   pipe_through :api
  # end
end
