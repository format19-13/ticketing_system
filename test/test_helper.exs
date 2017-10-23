ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(TicketingSystem.Repo, :manual)

defmodule TicketingSystem.TestHelper do
  use TicketingSystemWeb.ConnCase
  import Ecto, only: [build_assoc: 2]
  alias TicketingSystem.{Repo, Ticketing}
  alias TicketingSystem.Accounts.{User, Role}
  alias TicketingSystem.Ticketing.Agent
  alias TicketingSystem.Utils.Forge


  @session  Plug.Session.init([
      store:            :cookie,
      key:              "_app",
      encryption_salt:  "secret",
      signing_salt:     "secret",
      encrypt:          false
    ])

  def create_role(%{name: name}) do
    Role.changeset(%Role{}, %{name: name})
    |> Repo.insert
  end

  defp create_user(%Role{} = role, %{"email" => email, "lastname" => lastname, "name" => name , "password" => password,
   "password_confirmation" => password_confirmation}) do
    %User{}
    |> User.changeset(%{email: email, name: name, password: password, password_confirmation: password_confirmation, lastname: lastname, role_id: role.id, pending_approval: false})
    |> Repo.insert
  end

  def create_user(attrs \\ %{}) do
    {:ok, role} = create_role(%{name: "admin"})
    {:ok, user} = create_user(role, attrs)
    user
  end

  def create_ticket(attrs \\ %{}) do
    {:ok, agent} = create_agent()
    {:ok, ticket} =
      attrs
      |> Enum.into(Map.merge(attrs, %{asignee_id: agent.id, author_id: agent.id}))
      |> Ticketing.create_ticket()
    ticket
  end

  def create_agent() do
    {:ok, role} = create_role( %{name: "operator"})
    {:ok,user} = Forge.build_random_user(role)
      %Agent{user_id: user.id}
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.unique_constraint(:user_id)
      |> Repo.insert()
  end

  def create_empty_conn() do
    conn =
      build_conn()
      |> Map.put(:secret_key_base, String.duplicate("abcdefgh", 8))
      |> Plug.Session.call(@session)
      |> fetch_session
      |> fetch_flash
  end

  def not_redirected?(conn) do
    conn.status != 302
  end

  def build_dummy_conn() do
    build_conn()
    |> fetch_session
    |> put_session( :current_user, nil)
  end

  def get_current_session(conn) do
      get_session(conn, :current_user)
  end


end
