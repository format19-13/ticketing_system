defmodule TicketingSystemWeb.UserControllerTest do
  use TicketingSystemWeb.ConnCase

  alias TicketingSystem.Accounts

  @create_attrs %{email: "some_email@email.com", lastname: "some lastname", name: "some name", password: "some password", role: %{name: "developer"}}
  @update_attrs %{email: "some updated email", lastname: "some updated lastname", name: "some updated name", password: "some updated password"}
  @invalid_attrs %{email: nil, lastname: nil, name: nil, password: "1234"}

  setup do
    {:ok, role}  = TestHelper.create_role(%{name: "admin"})
    {:ok, user}  = {:ok, user} = TestHelper.create_user(role, %{email: "test@test.com", name: "testuser", password: "test"})
    {:ok, conn: build_conn()}
  end

  describe "new user" do
    test "renders form", %{conn: conn} do
      conn = get conn, user_path(conn, :new)
      assert html_response(conn, 200) =~ "Congratulations"
    end
  end

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

end
