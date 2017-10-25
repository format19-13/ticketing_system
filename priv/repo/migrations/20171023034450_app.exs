defmodule TicketingSystem.Repo.Migrations.App do
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
      add :pending_approval, :boolean
      add :encryption_version, :binary
      add :role_id, references(:roles, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:users, :email, name: :email_unique_index)

    create table(:agents) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :alias, :string

      timestamps()
    end

    create unique_index(:agents, :alias)

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
