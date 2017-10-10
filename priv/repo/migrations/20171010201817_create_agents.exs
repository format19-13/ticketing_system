defmodule TicketingSystem.Repo.Migrations.CreateAgents do
  use Ecto.Migration

  def change do
    create table(:agents) do
      add :name, :string
      add :lastname, :string
      add :role, :string

      timestamps()
    end

  end
end
