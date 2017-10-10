defmodule TicketingSystem.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :password, :string
      add :lastname, :string
      add :email, :string

      timestamps()
    end
    create unique_index(:users, :email, name: :email_unique_index)
  end
end
