defmodule TicketingSystem.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias TicketingSystem.Accounts.User


  schema "users" do
    field :email, :string
    field :lastname, :string
    field :name, :string
    field :password, :string
    field :raw_password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :password, :lastname, :email])
    |> validate_required([:name, :password, :lastname, :email])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password)
  end

end
