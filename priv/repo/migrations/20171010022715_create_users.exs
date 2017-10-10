defmodule TicketingSystem.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :password, :binary
      add :lastname, :string
      add :email, :string
      add :is_active, :boolean
      add :encryption_version, :binary
      timestamps()
    end
    create unique_index(:users, :email, name: :email_unique_index)

  end
end
