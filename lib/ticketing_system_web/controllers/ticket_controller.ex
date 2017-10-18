defmodule TicketingSystemWeb.TicketController do
  use TicketingSystemWeb, :controller
  use Rummage.Phoenix.Controller
  require Logger
  alias TicketingSystem.Repo
  alias TicketingSystem.Ticketing
  alias TicketingSystem.Ticketing.Ticket
  alias TicketingSystem.Ticketing.Agent
  alias TicketingSystem.Utils.QueryBuildUtils

  def index(conn, params) do
    user_id = get_session(conn,:current_user)
    agent = Repo.get_by!(Agent, user_id: user_id)
    Logger.debug params["field"]
    query_params = [{params["field"], params["value"]}, {"asignee_id", Integer.to_string(agent.id)}]
    {query, query_pagination} = Ticket.rummage(Ticket,
    QueryBuildUtils.add_filters_to_query_map(query_map: params["rummage"], fieds: query_params))
    tickets = Repo.all(query)
    |> Repo.preload(:asignee)
    |> Repo.preload(:author)
    render(conn, "index.html", tickets: tickets, rummage: query_pagination)
  end

  def new(conn, _params) do
    user_id = get_session(conn,:current_user)
    agent = Repo.get_by!(Agent, user_id: user_id)
    changeset = Ticketing.change_ticket(%Ticket{})
    render(conn, "new.html", changeset: changeset, agent: agent)
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
