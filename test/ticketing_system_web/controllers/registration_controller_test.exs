defmodule TicketingSystemWeb.RegistrationControllerTest do
  use TicketingSystemWeb.ConnCase

  alias TicketingSystem.Accounts
  alias TicketingSystem.TestHelper

  @valid_attrs %{"email" => "some@email.com", "lastname" => "some lastname", "name" => "some name",
                "password" => "some password", "password_confirmation" => "some password", "role" => %{"name" => "admin"}}

  @invalid_attrs %{"email"  =>  "clearly, not an email", "name"  =>  nil, "password"  =>  nil,
                "role" => %{"name" => "this role doesnt exists"}}


  describe "new registration" do
    test "renders form" do
      conn = get build_conn(), registration_path(conn, :new)
      assert html_response(conn, 200) =~ "Register"
    end
  end
  """
  describe "create registration" do
    test "redirects to show when data is valid" do
      conn = conn() |> post(registration_path(:create , user: @valid_attrs))
      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == registration_path(conn, :congrats, id)

      conn = get build_conn(), registration_path(conn, :congrats, id)
      assert html_response(conn, 200) =~ "Congratulations"
    end

    test "renders errors when data is invalid" do
      changeset = post  build_conn(), registration_path(conn, :create), user: @invalid_attrs
      assert html_response(conn, 200) =~ "Register"
    end
  end
  """
end
