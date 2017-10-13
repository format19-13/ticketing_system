defmodule TicketingSystemWeb.LayoutView do
  use TicketingSystemWeb, :view

  alias TicketingSystem.Accounts

  def logged_in?(conn) do
    Accounts.logged_in?(conn)
  end

  def get_authenticated_user_id(conn) do
     Accounts.get_authenticated_user_id(conn)
  end
end
