defmodule TicketingSystem.Plugs.RequireAuth do
  @behaviour Plug
  alias TicketingSystem.Accounts
  import Plug.Conn
  import Map

  def init(default), do: default

  def call(conn, _params) do
    case Accounts.logged_in?(conn) do
      false ->
        conn
        |> Phoenix.Controller.put_flash(:info, "Please log in or register to continue.")
        |> Phoenix.Controller.redirect(to: "/session/new")
      true ->
        conn
    end
  end
end
