defmodule TicketingSystem.Registrations do
  require Logger
  import Ecto.Query, warn: false
  alias Ecto.Multi
  alias TicketingSystem.Repo
  alias TicketingSystem.Tickets
  alias TicketingSystem.Tickets.Agent
  alias TicketingSystem.Accounts

def register_user(params) do
    Logger.debug inspect(params)
   multi = Multi.new()
   |> Multi.run(:user, fn _ -> Accounts.create_user(params) end)
   |> Multi.run(:agent, fn %{user: user} ->
       {:ok, ensure_agent_exists(user)}
     end)

   case Repo.transaction(multi) do
        {:ok, result} -> {:ok, result.user}
        {:error, _ , changeset, %{}} -> {:error, changeset }
   end
 end

 def ensure_agent_exists(%Accounts.User{} = user) do
  %Agent{user_id: user.id}
  |> Ecto.Changeset.change()
  |> Ecto.Changeset.unique_constraint(:user_id)
  |> Repo.insert()
  |> handle_existing_user()
end

defp handle_existing_user({:ok, user}), do: user
defp handle_existing_user({:error, changeset}) do
  Repo.get_by!(Agent, user_id: changeset.data.user_id)
end

end
