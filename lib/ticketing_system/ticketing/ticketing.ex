defmodule TicketingSystem.Ticketing do

  import Ecto.Query, warn: false

  alias TicketingSystem.{Accounts, Repo}
  alias TicketingSystem.Ticketing.{Ticket, Agent}
  alias TicketingSystem.Utils.QueryBuildUtils

  def list_tickets do
    Repo.all(Ticket)
  end

  def get_ticket!(id), do: Repo.get!(Ticket, id)

  def create_ticket(attrs \\ %{}) do
    %Ticket{}
    |> Ticket.changeset(attrs)
    |> Repo.insert()
  end

  def update_ticket(%Ticket{} = ticket, attrs) do
    ticket
    |> Ticket.changeset(attrs)
    |> Repo.update()
  end

  def delete_ticket(%Ticket{} = ticket) do
    Repo.delete(ticket)
  end

  def change_ticket(%Ticket{} = ticket) do
    Ticket.changeset(ticket, %{})
  end

  def get_agent_for_authenticated_user(conn) do
    user_id = Accounts.get_authenticated_user_id(conn)
    Repo.get_by!(Agent, user_id: user_id)
  end

  def get_query_for_tickets_asigned_to_user(conn, params) do
    agent = get_agent_for_authenticated_user(conn)
    query_params = [{params["field"], params["value"]}, {"asignee_id", Integer.to_string(agent.id)}]
    QueryBuildUtils.add_filters_to_query_map(query_map: params["rummage"], fieds: query_params)
  end
end
