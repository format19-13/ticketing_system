defmodule TicketingSystemWeb.TicketControllerTest do
  use TicketingSystemWeb.ConnCase, async: false

  alias TicketingSystem.TestHelper

  @create_attrs %{body: "some body", status: "open", title: "some title"}
  @update_attrs %{body: "some updated body", status: "closed", title: "some updated title"}
  @invalid_attrs %{body: nil, status: nil, title: nil}

  def fixture(:conn, agent) do
    TestHelper.create_empty_conn()
    |> put_session(:current_user, agent.user_id)
    |> put_session(:user_role, String.to_atom("operator"))
  end


  describe "index" do
    setup [:create_ticket_and_session]
    test "lists all tickets", %{conn: conn} do
      conn = get conn, ticket_path(conn, :index)
      assert html_response(conn, 200) =~ "Ticket dashboard"
    end
  end

  describe "new ticket" do
      setup [:create_ticket_and_session]
    test "renders form", %{conn: conn} do
      conn = get conn, ticket_path(conn, :new)
      assert html_response(conn, 200) =~ "New Ticket"
    end
  end

  describe "create ticket" do
      setup [:create_ticket_and_session]

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, ticket_path(conn, :create), ticket: @invalid_attrs
      assert html_response(conn, 200) =~ "New Ticket"
    end
  end

  describe "edit ticket" do
    setup [:create_ticket_and_session]

    test "renders form for editing chosen ticket", %{conn: conn, ticket: ticket} do
      conn = get conn, ticket_path(conn, :edit, ticket)
      assert html_response(conn, 200) =~ "Edit Ticket"
    end
  end

  describe "update ticket" do
    setup [:create_ticket_and_session]

    test "redirects when data is valid", %{conn: conn, ticket: ticket} do
      conn = put conn, ticket_path(conn, :update, ticket), ticket: @update_attrs
      assert redirected_to(conn) == ticket_path(conn, :show, ticket)

      conn = get conn, ticket_path(conn, :show, ticket)
      assert html_response(conn, 200) =~ "some updated body"
    end
    test "renders errors when data is invalid", %{conn: conn, ticket: ticket} do
      conn = put conn, ticket_path(conn, :update, ticket), ticket: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Ticket"
    end
  end

  defp create_ticket_and_session(_ ) do
    {:ok, agent} = TestHelper.create_agent()
    conn = fixture(:conn, agent)
    ticket = TestHelper.create_ticket(@create_attrs, agent)
    {:ok, ticket: ticket, conn: conn}
  end

end
