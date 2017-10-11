defmodule TicketingSystemWeb.DummyControllerTest do
  use TicketingSystemWeb.ConnCase

  alias TicketingSystem.Session

  @create_attrs %{lastname: "some lastname", name: "some name"}
  @update_attrs %{lastname: "some updated lastname", name: "some updated name"}
  @invalid_attrs %{lastname: nil, name: nil}

  def fixture(:dummy) do
    {:ok, dummy} = Session.create_dummy(@create_attrs)
    dummy
  end

  describe "index" do
    test "lists all dummies", %{conn: conn} do
      conn = get conn, dummy_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Dummies"
    end
  end

  describe "new dummy" do
    test "renders form", %{conn: conn} do
      conn = get conn, dummy_path(conn, :new)
      assert html_response(conn, 200) =~ "New Dummy"
    end
  end

  describe "create dummy" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, dummy_path(conn, :create), dummy: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == dummy_path(conn, :show, id)

      conn = get conn, dummy_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Dummy"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, dummy_path(conn, :create), dummy: @invalid_attrs
      assert html_response(conn, 200) =~ "New Dummy"
    end
  end

  describe "edit dummy" do
    setup [:create_dummy]

    test "renders form for editing chosen dummy", %{conn: conn, dummy: dummy} do
      conn = get conn, dummy_path(conn, :edit, dummy)
      assert html_response(conn, 200) =~ "Edit Dummy"
    end
  end

  describe "update dummy" do
    setup [:create_dummy]

    test "redirects when data is valid", %{conn: conn, dummy: dummy} do
      conn = put conn, dummy_path(conn, :update, dummy), dummy: @update_attrs
      assert redirected_to(conn) == dummy_path(conn, :show, dummy)

      conn = get conn, dummy_path(conn, :show, dummy)
      assert html_response(conn, 200) =~ "some updated lastname"
    end

    test "renders errors when data is invalid", %{conn: conn, dummy: dummy} do
      conn = put conn, dummy_path(conn, :update, dummy), dummy: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Dummy"
    end
  end

  describe "delete dummy" do
    setup [:create_dummy]

    test "deletes chosen dummy", %{conn: conn, dummy: dummy} do
      conn = delete conn, dummy_path(conn, :delete, dummy)
      assert redirected_to(conn) == dummy_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, dummy_path(conn, :show, dummy)
      end
    end
  end

  defp create_dummy(_) do
    dummy = fixture(:dummy)
    {:ok, dummy: dummy}
  end
end
