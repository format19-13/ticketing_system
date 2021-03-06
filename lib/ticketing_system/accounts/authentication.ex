defmodule TicketingSystem.Accounts.Authentication do
  import Ecto.Query, warn: false
  import Plug.Conn

  alias TicketingSystem.Repo
  alias TicketingSystem.Accounts.User

  def try_to_login(conn, params) do
    user = Repo.get_by(User, email: String.downcase(params["email"])) |> Repo.preload(:role)
    case should_authenticate(user, params["password"]) do
      true ->
      new_conn = login(conn, user)
      {:ok, new_conn}
      _    -> :error
    end
  end

  defp should_authenticate(user, _) when is_nil(user), do: false
  defp should_authenticate(%User{password: password, is_active: true} , password_attempted) when (password == password_attempted), do: true
  defp should_authenticate(_, _) , do: false

  def login(conn, user) do
      conn
      |> put_session(:current_user, user.id)
      |> put_session(:user_role, String.to_atom(user.role.name))
  end

  def logout(conn) do
      conn
      |> delete_session(:current_user)
      |> delete_session(:user_role)
  end

  def logged_in?(conn) do
    id = get_session(conn, :current_user)
    case id do
      nil -> false
      _ -> true
    end
  end

  def is_authorized?(conn) do
    get_authenticated_user_role(conn)
    |> search_in_config(:role_scopes)
    |> Enum.any?(fn(role_scope) ->
      role_scope == Enum.at(String.split(conn.request_path, "/"), 1)
    end)
  end

  def get_authenticated_user_id(conn) do
     get_session(conn, :current_user)
  end

  def get_authenticated_user_role(conn) do
     get_session(conn, :user_role)
  end

  def get_role_home_page(conn) do
    get_authenticated_user_role(conn)
    |> search_in_config(:role_home_page)
  end

  defp search_in_config(value_to_search, config_scope) do
    Map.get(Application.get_env(:ticketing_system, config_scope), value_to_search)
  end

end
