defmodule TicketingSystemWeb.TicketController do
  use TicketingSystemWeb, :controller
  use Rummage.Phoenix.Controller
  import Ecto.Query
  alias TicketingSystem.Repo
  alias TicketingSystem.Ticketing
  alias TicketingSystem.Accounts.User
  alias TicketingSystem.Ticketing.Ticket
  alias TicketingSystem.Ticketing.Agent
  alias Rummage.Ecto.Services.BuildSearchQuery

  def index(conn, params) do
    user_id = get_session(conn,:current_user)

  {query, rummage} = Ticket
  |> Ticket.rummage(params["rummage"])
             tickets = Repo.all(from t in query,
                     join: a in Agent, where: a.id == t.asignee_id,
                     join: u in User, where: u.id == a.user_id and u.id == ^user_id )
                     |>
                     Repo.preload(:asignee)
    render(conn, "index.html", tickets: tickets, rummage: rummage)
  end

  def new(conn, _params) do
    changeset = Ticketing.change_ticket(%Ticket{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ticket" => ticket_params}) do
    case Ticketing.create_ticket(ticket_params) do
      {:ok, ticket} ->
        conn
        |> put_flash(:info, "Ticket created successfully.")
        |> redirect(to: ticket_path(conn, :show, ticket))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    ticket = Ticketing.get_ticket!(id)
    render(conn, "show.html", ticket: ticket)
  end

  def edit(conn, %{"id" => id}) do
    ticket = Ticketing.get_ticket!(id)
    changeset = Ticketing.change_ticket(ticket)
    render(conn, "edit.html", ticket: ticket, changeset: changeset)
  end

  def update(conn, %{"id" => id, "ticket" => ticket_params}) do
    ticket = Ticketing.get_ticket!(id)

    case Ticketing.update_ticket(ticket, ticket_params) do
      {:ok, ticket} ->
        conn
        |> put_flash(:info, "Ticket updated successfully.")
        |> redirect(to: ticket_path(conn, :show, ticket))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", ticket: ticket, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ticket = Ticketing.get_ticket!(id)
    {:ok, _ticket} = Ticketing.delete_ticket(ticket)

    conn
    |> put_flash(:info, "Ticket deleted successfully.")
    |> redirect(to: ticket_path(conn, :index))
  end
end
