defmodule TicketingSystem.Plugs.RedirectAuthenticated do
  @behaviour Plug
  import Plug.Conn
  import Map
  alias TicketingSystem.Router.Helpers
  alias TicketingSystem.Accounts
  alias TicketingSystem.Accounts.User

  def init(default), do: default

  def call(conn, _params) do
    case Accounts.logged_in?(conn) do
      true ->
        conn
        |> Phoenix.Controller.redirect(to: "/")
      false -> conn
    end
  end
end
