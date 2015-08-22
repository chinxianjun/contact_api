defmodule ContactApi.Router do
  use ContactApi.Web, :router

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

  scope "/", ContactApi do
  #  pipe_through :browser # Use the default browser stack
  #
  #  get "/", PageController, :index

    pipe_through :api

    scope "/v1", V1, as: :v1 do
      resources "/customers", CustomerController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", ContactApi do
  #   pipe_through :api
  # end
end
