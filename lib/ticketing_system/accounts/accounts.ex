defmodule TicketingSystem.Accounts do
  import Ecto.Query, warn: false

  alias TicketingSystem.Repo
  alias TicketingSystem.Accounts.{User, Role}

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do:
    User
    |> Repo.get!(id)
    |> Repo.preload(:role)

  def create_user(attrs \\ %{}) do
    role_name = attrs["role"]["name"]
    role = Repo.get_by(Role, name: role_name)
    case role do
      nil ->
        %User{role: nil}
        |> User.changeset(attrs)
      role ->
        attrs = Map.put(attrs, "role_id", role.id)
        %User{}
        |> User.changeset(attrs)
        |> Repo.insert
    end
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

  def logout(conn) do
      Authentication.logout(conn)
  end

  def is_authorized?(conn) do
      Authentication.is_authorized?(conn)
  end

  def logged_in?(conn) do
      Authentication.logged_in?(conn)
  end

  def get_authenticated_user_id(conn) do
      Authentication.get_authenticated_user_id(conn)
  end

  def get_authenticated_user_role(conn) do
      Authentication.get_authenticated_user_role(conn)
  end

  def get_role_home_page(conn) do
      Authentication.get_role_home_page(conn)
  end

end
