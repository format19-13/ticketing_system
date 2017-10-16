defmodule TicketingSystemWeb.UserView do
  use TicketingSystemWeb, :view
  use Rummage.Phoenix.View

  def accept(user) do
    user
    |> Map.put(:is_active, true)
    |> Map.put(:pending_approval, false)
  end

  def reject(user) do
    user
    |> Map.put(:is_active, false)
    |> Map.put(:pending_approval, false)
  end


end
