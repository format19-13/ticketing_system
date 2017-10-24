defmodule TicketingSystemWeb.PageController do
  use TicketingSystemWeb, :controller
  alias TicketingSystem.Accounts

  def index(conn, _params) do
    redirect(conn, to: Accounts.get_role_home_page(conn))
  end
end
