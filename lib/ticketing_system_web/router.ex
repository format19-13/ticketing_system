defmodule TicketingSystemWeb.Router do
  use TicketingSystemWeb, :router

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

  scope "/", TicketingSystemWeb do
    pipe_through :browser # Use the default browser stack
    resources "/users", UserController, only: [:new, :create, :show]
    resources "/registration", RegistrationController, only: [:new, :create]
    resources "/session", SessionController, only: [:new, :create, :delete]
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", TicketingSystemWeb do
  #   pipe_through :api
  # end
end
