defmodule TicketingSystemWeb.SessionController do
  require Logger
  use TicketingSystemWeb, :controller

  alias TicketingSystem.Accounts

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
  case Accounts.try_to_login(conn, session_params) do
    {:ok, conn} ->
      conn
      |> put_flash(:info, "Logged in")
      |> redirect(to: "/")
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
