defmodule TicketingSystem.Session do
  @moduledoc """
  The Session context.
  """
  require Logger
  import Ecto.Query, warn: false
  alias TicketingSystem.Repo
  alias TicketingSystem.Accounts.User

  def login(params, repo) do
  user = repo.get_by(User, email: String.downcase(params["email"]))
  case should_authenticate(user, params["password"]) do
    true -> {:ok, user}
    _    -> :error
  end
end

  defp should_authenticate(user, _) when is_nil(user), do: false
  defp should_authenticate(%User{password: password} = user, password_attempted) when (password == password_attempted), do: true
  defp should_authenticate(_, _) , do: false

end
