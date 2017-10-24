defmodule TicketingSystem.Plugs.RequireNotAuthenticatedTest do
    use TicketingSystemWeb.ConnCase
    use ExUnit.Case, async: true
    alias TicketingSystem.Plugs.RequireNotAuthenticated
    alias TicketingSystem.TestHelper

    test "user is not redirected when is not signed" do
      conn =
        TestHelper.create_empty_conn()
        |> RequireNotAuthenticated.call(%{})
      assert TestHelper.not_redirected?(conn)
    end

    test "user is redirected when there is a session" do
      conn =
        TestHelper.create_empty_conn()
        |> put_session(:current_user, 1)
        |> put_session(:user_role, String.to_atom("operator"))
        |> RequireNotAuthenticated.call(%{})
     assert redirected_to(conn) == "/ticket"
    end


end
