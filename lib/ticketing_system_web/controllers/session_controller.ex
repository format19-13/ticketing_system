defmodule TicketingSystemWeb.SessionController do
  require Logger
  use TicketingSystemWeb, :controller

  alias TicketingSystem.Accounts

  def index(conn, _params) do
    dummies = Accounts.list_dummies()
    render(conn, "index.html", dummies: dummies)
  end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
  case Accounts.try_to_login(conn, session_params) do
    {:ok, user} ->
      conn
      |> put_flash(:info, "Logged in")
      |> redirect(to: "/")
    :error ->
      conn
      |> put_flash(:error, "Wrong email or password")
      |> render("new.html")
  end
end

  def show(conn, %{"id" => id}) do
    session = Accounts.get_session!(id)
    render(conn, "show.html", session: session)
  end

  def edit(conn, %{"id" => id}) do
    session = Accounts.get_session!(id)
    changeset = Accounts.change_session(session)
    render(conn, "edit.html", session: session, changeset: changeset)
  end

  def update(conn, %{"id" => id, "session" => session_params}) do
    session = Accounts.get_session!(id)

    case Accounts.update_session(session, session_params) do
      {:ok, session} ->
        conn
        |> put_flash(:info, "Session updated successfully.")
        |> redirect(to: session_path(conn, :show, session))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", session: session, changeset: changeset)
    end
  end

  def delete(conn, _) do
  conn
  |> delete_session(:current_user)
  |> put_flash(:info, "Logged out")
  |> redirect(to: "/")
end
end
