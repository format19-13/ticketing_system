defmodule TicketingSystemWeb.SessionControllerTest do
  use TicketingSystemWeb.ConnCase

  alias TicketingSystem.Accounts
  alias TicketingSystem.Accounts.User

  describe "create session" do
    setup do
      {:ok, role}  = TestHelper.create_role(%{name: "admin"})
      {:ok, user}  = {:ok, user} = TestHelper.create_user(role, %{email: "test@test.com", name: "testuser", password: "test"})
      {:ok, conn: build_conn()}
    end

 test "shows the login form", %{conn: conn} do
   conn = get conn, session_path(conn, :new)
   assert html_response(conn, 200) =~ "Login"
 end

 test "creates a new user session for a valid user", %{conn: conn} do
   conn = post conn, session_path(conn, :create), user: %{email: "test@test.com", password: "test"}
   assert get_session(conn, :current_user)
   assert get_flash(conn, :info) == "Sign in successful!"
   assert redirected_to(conn) == page_path(conn, :index)
 end

 test "does not create a session with a bad login", %{conn: conn} do
   conn = post conn, session_path(conn, :create), user: %{username: "test@test.com", password: "wrong"}
   refute get_session(conn, :current_user)
   assert get_flash(conn, :error) == "Invalid username/password combination!"
 end

 test "does not create a session if user does not exist", %{conn: conn} do
   conn = post conn, session_path(conn, :create), user: %{username: "foo", password: "wrong"}
   refute get_session(conn, :current_user)
   assert get_flash(conn, :error) == "Invalid username/password combination!"
 end
end

  describe "delete session" do
    setup do
      User.changeset(%User{}, %{name: "test", password: "test", email: "test@test.com"})
      |> Repo.insert
      {:ok, conn: build_conn()}
    end
    test "deletes chosen session", %{conn: conn, session: session} do
      conn = delete conn, session_path(conn, :delete, session)
      assert redirected_to(conn) == session_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, session_path(conn, :show, session)
      end
    end
  end

end
