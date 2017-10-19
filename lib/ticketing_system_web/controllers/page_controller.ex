defmodule TicketingSystemWeb.PageController do
  use TicketingSystemWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: "/session/new")
  end
end
