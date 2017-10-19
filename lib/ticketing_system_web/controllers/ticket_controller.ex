defmodule TicketingSystemWeb.TicketController do
  use TicketingSystemWeb, :controller
  use Rummage.Phoenix.Controller
  alias TicketingSystem.{Repo, Ticketing}
  alias TicketingSystem.Ticketing.Ticket

  def index(conn, params) do
    {query, query_pagination} = Ticket.rummage(Ticket, Ticketing.get_query_for_tickets_asigned_to_user(conn, params))
    tickets = Repo.all(query)
    |> Repo.preload(:asignee)
    |> Repo.preload(:author)
    render(conn, "index.html", tickets: tickets, rummage: query_pagination)
  end

  def new(conn, _params) do
    agent =  Ticketing.get_agent_for_authenticated_user(conn)
    changeset = Ticketing.change_ticket(%Ticket{})
    render(conn, "new.html", changeset: changeset, agent: agent)
  end

  def create(conn, %{"ticket" => ticket_params}) do
    agent = Ticketing.get_agent_for_authenticated_user(conn)
    case Ticketing.create_ticket(Map.put(ticket_params, "author_id", agent.id)) do
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
    |> Repo.preload(:asignee)
    |> Repo.preload(:author)
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
