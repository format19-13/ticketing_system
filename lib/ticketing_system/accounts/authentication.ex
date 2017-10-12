defmodule TicketingSystem.Accounts.Authentication do
  import Ecto.Query, warn: false
  import Plug.Conn
  alias TicketingSystem.Repo

  alias TicketingSystem.Accounts.User
  alias TicketingSystem.Accounts.Role

  def try_to_login(conn, params) do
    user = Repo.get_by(User, email: String.downcase(params["email"]))
    case should_authenticate(user, params["password"]) do
      true ->
      login(conn, user)
      {:ok, user}
      _    -> :error
    end
  end

  def login(conn, user) do
      conn
      |> put_session(:current_user, user.id)
      |> configure_session(renew: true)
  end

  defp should_authenticate(user, _) when is_nil(user), do: false
  defp should_authenticate(%User{password: password} , password_attempted) when (password == password_attempted), do: true
  defp should_authenticate(_, _) , do: false

  def logged_in?(conn) do
     case current_user(conn) do
      %User{} -> true
      _ -> false
    end
  end

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id, do: TicketingSystem.Accounts.get_user!(id)
  end

  def is_admin?(conn) do
      current_user(conn)
      |> check_is_admin()
  end

  defp check_is_admin(user) when is_nil(user), do: false
  defp check_is_admin(%User{role: %Role{name: name}}) when name == "admin", do: true
end
