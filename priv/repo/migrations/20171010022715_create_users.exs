defmodule TicketingSystem.Repo.Migrations.CreateApp do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string, null: false

      timestamps()
    end
    create unique_index(:roles, :name)

    create table(:users) do
      add :name, :string
      add :password, :binary, null: false
      add :lastname, :string
      add :email, :string, null: false
      add :is_active, :boolean
      add :encryption_version, :binary
      add :role_id, references(:roles, on_delete: :delete_all), null: false

      timestamps()
    end
    create unique_index(:users, :email, name: :email_unique_index)

    create table(:agents) do
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
