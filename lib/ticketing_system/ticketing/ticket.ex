defmodule TicketingSystem.Ticketing.Ticket do
  use Ecto.Schema
  use Rummage.Ecto
  import Ecto.Changeset
  alias TicketingSystem.Ticketing.Ticket
@timestamps_opts [usec: Mix.env != :test]

  schema "tickets" do
    field :body, :string
    field :status, :string
    field :title, :string
    belongs_to :author, TicketingSystem.Ticketing.Agent
    belongs_to :asignee, TicketingSystem.Ticketing.Agent

    timestamps()
  end

  @doc false
  def changeset(%Ticket{} = ticket, attrs) do
    ticket
    |> cast(attrs, [:title, :body, :status, :author_id, :asignee_id])
    |> validate_required([:title, :body, :status, :author_id, :asignee_id])
    |> foreign_key_constraint(:asignee_id)
    |> foreign_key_constraint(:author_id)
    |> validate_inclusion(:status, ["open", "closed"])
  end
end
