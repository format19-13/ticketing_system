defmodule TicketingSystem.Plugs.RequireAuthenticatedTest do
    use TicketingSystemWeb.ConnCase
    use ExUnit.Case, async: true
    alias TicketingSystem.Plugs.RequireAuthenticated
    alias TicketingSystem.TestHelper

    test "user is redirected when current_user is not assigned" do
      conn =
        TestHelper.create_empty_conn()
        |> RequireAuthenticated.call(%{})
      assert redirected_to(conn) == "/session/new"
    end

    test "user is not redirected when there is a session" do
      conn =
        TestHelper.create_empty_conn()
        |> put_session(:current_user, 1)
        |> RequireAuthenticated.call(%{})
     assert TestHelper.not_redirected?(conn)
    end


end
