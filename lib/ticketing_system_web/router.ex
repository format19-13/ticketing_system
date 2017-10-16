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

  pipeline :not_authenticated do
    plug TicketingSystem.Plugs.RedirectAuthenticated, repo: Auth.Repo
  end

  pipeline :authenticated do
    plug TicketingSystem.Plugs.RequireAuth, repo: Auth.Repo
  end

  pipeline :admin do
    plug TicketingSystem.Plugs.AministratorRequired, repo: Auth.Repo
  end

  scope "/", TicketingSystemWeb do
    pipe_through [:browser, :authenticated]
    resources "/session", SessionController, only: [:delete]
    get "/", PageController, :index
  end

  scope "/", TicketingSystemWeb do
    pipe_through [:browser, :not_authenticated]
    resources "/users", UserController, only: [:new, :create]
    resources "/registration", RegistrationController, only: [:new, :create]
    resources "/session", SessionController, only: [:new, :create]
  end

  scope "/admin", TicketingSystemWeb do
      pipe_through [:browser, :authenticated, :admin]

      resources "/users", UserController, only: [:index, :update]
  end

  # Other scopes may use custom stacks.
  # scope "/api", TicketingSystemWeb do
  #   pipe_through :api
  # end
end
