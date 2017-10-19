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

  pipeline :require_not_authenticated do
    plug TicketingSystem.Plugs.RequireNotAuthenticated, repo: TicketingSystem.Repo
  end

  pipeline :require_authenticated do
    plug TicketingSystem.Plugs.RequireAuthenticated, repo: TicketingSystem.Repo
  end

  pipeline :require_permissions do
    plug TicketingSystem.Plugs.RequirePermissions, repo: TicketingSystem.Repo
  end

  scope "/", TicketingSystemWeb do
    pipe_through [:browser, :require_authenticated]
    resources "/", PageController, only: [:index]
    resources "/session", SessionController, only: [:delete]
  end

  scope "/", TicketingSystemWeb do
    pipe_through [:browser, :require_not_authenticated]

    resources "/registration", RegistrationController, only: [:new, :create]
    resources "/session", SessionController, only: [:new, :create]
  end

  scope "/admin", TicketingSystemWeb do
      pipe_through [:browser, :require_authenticated, :require_permissions]

      resources "/users", UserController, only: [:index, :update]
  end

  scope "/ticket", TicketingSystemWeb do
      pipe_through [:browser, :require_authenticated, :require_permissions]

      resources "/", TicketController
  end

  # Other scopes may use custom stacks.
  # scope "/api", TicketingSystemWeb do
  #   pipe_through :api
  # end
end
