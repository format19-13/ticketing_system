defmodule TicketingSystemWeb.UserController do
  use TicketingSystemWeb, :controller
  import Ecto.Query
  alias TicketingSystem.{Accounts, Repo}
  alias TicketingSystem.Accounts.User

  def index(conn, params) do
    {query, rummage} = User
    |> User.rummage(params["rummage"])
       users = Repo.all(from u in query,
       where: u.pending_approval == true)
    render(conn, "index.html", users: users, rummage: rummage)
  end
  
  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, _ } ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: "/admin/users")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end


end
