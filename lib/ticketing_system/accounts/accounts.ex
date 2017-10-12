defmodule TicketingSystem.Accounts do

  import Ecto.Query, warn: false
  import TicketingSystem.Accounts.Authentication
  alias TicketingSystem.Repo
  alias TicketingSystem.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do:
    User
    |> Repo.get!(id)
    |> Repo.preload(:role)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias TicketingSystem.Accounts.Role

  def list_roles do
    Repo.all(Role)
  end

  def get_role!(id), do: Repo.get!(Role, id)

  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  def update_role(%Role{} = role, attrs) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  def delete_role(%Role{} = role) do
    Repo.delete(role)
  end

  def change_role(%Role{} = role) do
    Role.changeset(role, %{})
  end

  alias TicketingSystem.Accounts.Authentication

  def try_to_login(conn, params) do
    Authentication.try_to_login(conn, params)
  end

  def login(conn, user) do
    Authentication.try_to_login(conn, user)
  end

  def is_admin?(conn) do
      Authentication.is_admin?(conn)
  end

  def logged_in?(conn) do
      Authentication.logged_in?(conn)
  end
end
