defmodule TicketingSystemWeb.UserControllerTest do
  use TicketingSystemWeb.ConnCase

  alias TicketingSystem.Accounts

  @create_attrs %{email: "some_email@email.com", lastname: "some lastname", name: "some name", password: "some password", role: %{name: "developer"}}
  @update_attrs %{email: "some updated email", lastname: "some updated lastname", name: "some updated name", password: "some updated password"}
  @invalid_attrs %{email: nil, lastname: nil, name: nil, password: "1234"}

  setup do
  end

"""
  describe "create user" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == user_path(conn, :show, id)

      conn = get conn, user_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show User"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @invalid_attrs
      assert html_response(conn, 200) =~ "New User"
    end

  end
    """
end
