defmodule TicketingSystem.Plugs.RequireNotAuthenticated do
  @behaviour Plug
  import Plug.Conn
  alias TicketingSystem.Accounts

  def init(default), do: default

  def call(conn, _params) do
    case Accounts.logged_in?(conn) do
      true ->
        conn
        |> Phoenix.Controller.redirect(to: Accounts.get_role_home_page(conn)) |> halt()
      false -> conn
    end
  end
end
