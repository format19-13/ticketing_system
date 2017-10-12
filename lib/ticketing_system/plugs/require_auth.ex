defmodule TicketingSystem.Plugs.RequireAuth do
  @behaviour Plug
  import Plug.Conn
  import Map
  alias TicketingSystem.Router.Helpers

  def init(default), do: default

  def call(conn, _params) do
    case conn |> Map.get(:assigns, %{}) |> Map.get(:current_user, %{}) do
      nil ->
        conn
        |> Plug.Conn.put_session(:redirect_url, conn.request_path)
        |> Phoenix.Controller.put_flash(:info, "Please log in or register to continue.")
        |> Phoenix.Controller.redirect(to: Helpers.registration_path(conn, :new))
      _ ->
        conn
    end
  end
end
