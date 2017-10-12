defmodule TicketingSystemWeb.RegistrationControllerTest do
  use TicketingSystemWeb.ConnCase

  alias TicketingSystem.Accounts
  alias TicketingSystem.TestHelper

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:registration) do
  {:ok, user_role}     = TestHelper.create_role(%{name: "user", admin: false})
   {:ok, nonadmin_user} = TestHelper.create_user(user_role, %{email: "nonadmin@test.com", username: "nonadmin", password: "test", password_confirmation: "test"})
  end

  describe "new registration" do
    test "renders form", %{conn: conn} do
      conn = get conn, registration_path(conn, :new)
      assert html_response(conn, 200) =~ "New Registration"
    end
  end

  describe "create registration" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, registration_path(conn, :create), registration: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == registration_path(conn, :show, id)

      conn = get conn, registration_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Registration"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, registration_path(conn, :create), registration: @invalid_attrs
      assert html_response(conn, 200) =~ "New Registration"
    end
  end

  defp create_registration(_) do
    registration = fixture(:registration)
    {:ok, registration: registration}
  end
end
