defmodule TicketingSystemWeb.SessionController do
  use TicketingSystemWeb, :controller
  require Logger
  alias TicketingSystem.Accounts

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
  case Accounts.try_to_login(conn, session_params) do
    {:ok, new_conn} ->
      new_conn
      |> put_flash(:info, "Logged in")
      |> redirect(to: Accounts.get_role_home_page(new_conn))
    :error ->
      conn
      |> put_flash(:error, "Wrong email or password")
      |> render("new.html")
  end
end

  def delete(conn, _) do
  conn
  |> Accounts.logout()
  |> put_flash(:info, "Logged out")
  |> redirect(to: "/session/new")
  end
end
