defmodule TicketingSystem.Tickets.Agent do
  use Ecto.Schema
  import Ecto.Changeset
  alias TicketingSystem.Tickets.Agent


  schema "agents" do
    belongs_to :user, TicketingSystem.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Agent{} = agent, attrs) do
    agent
  end
end
