defmodule TicketingSystemWeb.AgentController do
  use TicketingSystemWeb, :controller

  alias TicketingSystem.Tickets
  

  def create(conn, %{"agent" => agent_params}) do
    case Tickets.create_agent(agent_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Agent created successfully.")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    agent = Tickets.get_agent!(id)
    render(conn, "show.html", agent: agent)
  end

end
