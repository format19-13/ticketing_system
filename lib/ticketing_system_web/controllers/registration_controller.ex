defmodule TicketingSystemWeb.RegistrationController do
  use TicketingSystemWeb, :controller
  alias TicketingSystem.{Accounts, Registrations}
  alias TicketingSystem.Accounts.{Role, User}

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{role: %Role{}})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Registrations.register_user(user_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "User created successfully.")
        render(conn, "congrats.html")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
