defmodule TicketingSystem.Accounts.User do
  use Ecto.Schema

  import Ecto.Changeset
  alias Cloak.EncryptedBinaryField
  alias TicketingSystem.Accounts.User
  alias TicketingSystem.Accounts.Role

  @timestamps_opts [usec: Mix.env != :test]

  schema "users" do
    field :email, :string
    field :lastname, :string
    field :name, :string
    field :password, EncryptedBinaryField
    field :is_active, :boolean
    field :encryption_version, :binary
    belongs_to :role, TicketingSystem.Accounts.Role

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :password, :lastname, :email, :role_id])
    |> validate_required([:name, :password, :lastname, :email])
    |> foreign_key_constraint(:role_id)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password)
    |> put_change(:encryption_version, Cloak.version)
    |> put_change(:is_active, false)
  end


end
