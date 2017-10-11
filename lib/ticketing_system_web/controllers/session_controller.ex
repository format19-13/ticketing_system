defmodule TicketingSystemWeb.SessionController do
  require Logger
  use TicketingSystemWeb, :controller

  alias TicketingSystem.Accounts
  alias TicketingSystem.Session

  def index(conn, _params) do
    dummies = Accounts.list_dummies()
    render(conn, "index.html", dummies: dummies)
  end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
  case Session.login(session_params, TicketingSystem.Repo) do
    {:ok, user} ->
      conn
      |> put_session(:current_user, user.id)
      |> put_flash(:info, "Logged in")
      |> redirect(to: "/")
    :error ->
      conn
      |> put_flash(:info, "Wrong email or password")
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

  def delete(conn, %{"id" => id}) do
    session = Accounts.get_session!(id)
    {:ok, _session} = Accounts.delete_session(session)

    conn
    |> put_flash(:info, "Session deleted successfully.")
    |> redirect(to: session_path(conn, :index))
  end
end
