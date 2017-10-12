ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(TicketingSystem.Repo, :manual)
defmodule TicketingSystem.TestHelper do

import Ecto, only: [build_assoc: 2]
alias TicketingSystem.Repo
alias TicketingSystem.Accounts.User
alias TicketingSystem.Accounts.Role


  def create_role(%{name: name}) do
    Role.changeset(%Role{}, %{name: name})
    |> Repo.insert
  end

  defp create_user(%Role{} = role, %{"email" => email, "lastname" => lastname, "name" => name , "password" => password,
   "password_confirmation" => password_confirmation}) do
    role
    |> build_assoc(:users)
    |> User.changeset(%{email: email, name: name, password: password, password_confirmation: password_confirmation, lastname: lastname})
    |> Repo.insert
  end

  def create_user(attrs \\ %{}) do
    {:ok, role} = create_role(%{name: "admin"})
    {:ok, user} = create_user(role, attrs)
    user
  end

end
