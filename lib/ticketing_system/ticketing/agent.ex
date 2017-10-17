defmodule TicketingSystem.Ticketing.Agent do
  use Ecto.Schema
  import Ecto.Changeset
  alias TicketingSystem.Ticketing.Agent


  schema "agents" do
    belongs_to :user, TicketingSystem.Accounts.User
    field :alias, :string
    timestamps()
  end

  @doc false
  def changeset(%Agent{} = agent, attrs) do
    agent
    |> cast(attrs, [:user_id, :alias])
  end
end
