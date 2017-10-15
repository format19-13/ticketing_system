defmodule TicketingSystem.UserApiView do
  use TicketingSystemWeb, :view

  def render("index.json", %{users: users, draw_number: draw_number}) do
    %{ recordsTotal:  users.total_entries,
       draw: draw_number,
       recordsFiltered: users.total_entries,
       data: Enum.map(users, &user_josn/1)
     }
  end

  def user_josn(user) do
    %{
      name: user.name,
      lastname: user.lastname,
      email: user.email
    }
  end
end
