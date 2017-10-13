defmodule TicketingSystem.Accounts.Role do
  use Ecto.Schema
  import Ecto.Changeset
  alias TicketingSystem.Accounts.Role

  @timestamps_opts [usec: Mix.env != :test]
  
  schema "roles" do
    field :name, :string
    has_many :users, TicketingSystem.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Role{} = role, attrs) do
    role
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_inclusion(:name, ["developer", "admin", "operator"])
  end
end
