defmodule TicketingSystem.Tickets.Agent do
  use Ecto.Schema
  import Ecto.Changeset
  alias TicketingSystem.Tickets.Agent


  schema "agents" do
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(%Agent{} = agent, attrs) do
    agent
    |> cast(attrs, [:role])
    |> validate_required([:role])
  end
end
