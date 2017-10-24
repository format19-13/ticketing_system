defmodule TicketingSystemWeb.RegistrationControllerTest do
  use TicketingSystemWeb.ConnCase

  alias TicketingSystem.TestHelper

  def fixture(:conn) do
    TestHelper.create_empty_conn()
  end

  describe "new registration" do
    setup [:create_empty_conn]
    test "renders form", %{conn: conn} do
      conn = get conn, registration_path(conn, :new)
      assert html_response(conn, 200) =~ "Register"
    end
  end

  defp create_empty_conn(_ ) do
    conn = fixture(:conn)
    {:ok, conn: conn}
  end

end
