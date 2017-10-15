defmodule TicketingSystem.UserApiController do
  use TicketingSystemWeb, :controller
  import Ecto.Query
  alias TicketingSystem.Accounts.User
  alias TicketingSystem.DatatablesParamParser

  def index(conn, params) do
    {page_size, page_number, draw_number, search_term} = DatatablesParamParser.build_paging_info(params)
    users = retrieve_users(page_size, page_number, search_term)
    render(conn, :index,
           users: users,
           page_number: page_number,
           draw_number: draw_number)
  end

  defp retrieve_users(page_size, page_number, search_term) do
    query = from u in User,
    select: struct(u, [:email, :name, :lastname])
    TicketingSystem.Repo.paginate(query, page: page_number, page_size: page_size)
  end

  defp add_filter(query, search_term) when search_term == nil or search_term == "", do: query
  defp add_filter(query, original_search_term) do
    search_term = "#{original_search_term}%"
    from u in query,
    where: like(u.is_active, ^search_term)
  end

end
