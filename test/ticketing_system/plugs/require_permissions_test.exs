defmodule TicketingSystem.Plugs.RequirePermissionsTest do
    use TicketingSystemWeb.ConnCase
    use ExUnit.Case, async: true
    alias TicketingSystem.Plugs.RequirePermissions
    alias TicketingSystem.TestHelper

    test "user is redirected when doesnt have permissions" do
        conn =
          TestHelper.create_empty_conn()
          |> put_session(:current_user, 1)
          |> put_session(:user_role, String.to_atom("operator"))
          |> put_session(:request_path, "/admin/users")
          |> RequirePermissions.call(%{})
       assert redirected_to(conn) == "/ticket"
    end

    test "user is not redirected when has permissions" do
      conn =
        TestHelper.create_empty_conn()
        |> put_session(:current_user, 1)
        |> put_session(:user_role, String.to_atom("operator"))
        |> put_session(:request_path, "/ticket")
        |> RequirePermissions.call(%{})
     assert redirected_to(conn) == "/ticket"
    end


end
