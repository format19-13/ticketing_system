defmodule TicketingSystem.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cloak.EncryptedBinaryField
  alias TicketingSystem.Accounts.User

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
    |> cast(attrs, [:name, :password, :lastname, :email, :role])
    |> validate_required([:name, :password, :lastname, :email, :role])
    |> unique_constraint(:email)
    |> cast_assoc(:role)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password)
    |> cast(attrs, ~w(password), ~w(encryption_version))
    |> put_change(:encryption_version, Cloak.version)
    |> put_change(:is_active, false)
  end

end
