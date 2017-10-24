defmodule TicketingSystem.Plugs.RequirePermissions do
  @behaviour Plug
  import Plug.Conn
  alias TicketingSystem.Accounts

  def init(default), do: default

  def call(conn, _params) do
    case Accounts.is_authorized?(conn) do
      true ->
        conn
      false ->
        Phoenix.Controller.redirect(conn, to: Accounts.get_role_home_page(conn)) |> halt()
    end
  end
end
