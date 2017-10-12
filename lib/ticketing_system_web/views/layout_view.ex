defmodule TicketingSystemWeb.LayoutView do
  use TicketingSystemWeb, :view

  alias TicketingSystem.Accounts

  def logged_in?(conn) do
    Accounts.logged_in?(conn)
  end
end
