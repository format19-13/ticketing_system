defmodule TicketingSystem.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :title, :string
      add :body, :string
      add :status, :string
      add :author_id, references(:agents, on_delete: :nothing)
      add :asignee_id, references(:agents, on_delete: :nothing)

      timestamps()
    end

    create index(:tickets, [:title])
    create index(:tickets, [:asignee_id])
  end
end
