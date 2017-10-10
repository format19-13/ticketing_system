defmodule TicketingSystem.Registrations do

  import Ecto.Query, warn: false
  alias Ecto.Multi
  alias TicketingSystem.Repo
  alias TicketingSystem.Tickets
  alias TicketingSystem.Accounts

  def register_user(params \\ %{}) do
   Multi.new()
   |> Multi.run(:user, fn _ -> Accounts.create_user(params) end)
   |> Multi.run(:agent, fn _ -> Tickets.create_agent(params) end)
   |> Repo.transaction()
 end

end
