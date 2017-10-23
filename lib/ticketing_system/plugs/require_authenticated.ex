defmodule TicketingSystem.Plugs.RequireAuthenticated do
  @behaviour Plug
  import Plug.Conn
  alias TicketingSystem.Accounts

  def init(default), do: default

  def call(conn, _params) do
    case Accounts.logged_in?(conn) do
      false ->
        conn
        |> Phoenix.Controller.put_flash(:info, "Please log in or register to continue.")
        |> Phoenix.Controller.redirect(to: "/session/new") |> halt()
      true ->
        conn
    end
  end
end
