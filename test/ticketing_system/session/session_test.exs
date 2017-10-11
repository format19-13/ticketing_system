defmodule TicketingSystem.SessionTest do
  use TicketingSystem.DataCase

  alias TicketingSystem.Session

  describe "dummies" do
    alias TicketingSystem.Session.Dummy

    @valid_attrs %{lastname: "some lastname", name: "some name"}
    @update_attrs %{lastname: "some updated lastname", name: "some updated name"}
    @invalid_attrs %{lastname: nil, name: nil}

    def dummy_fixture(attrs \\ %{}) do
      {:ok, dummy} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Session.create_dummy()

      dummy
    end

    test "list_dummies/0 returns all dummies" do
      dummy = dummy_fixture()
      assert Session.list_dummies() == [dummy]
    end

    test "get_dummy!/1 returns the dummy with given id" do
      dummy = dummy_fixture()
      assert Session.get_dummy!(dummy.id) == dummy
    end

    test "create_dummy/1 with valid data creates a dummy" do
      assert {:ok, %Dummy{} = dummy} = Session.create_dummy(@valid_attrs)
      assert dummy.lastname == "some lastname"
      assert dummy.name == "some name"
    end

    test "create_dummy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Session.create_dummy(@invalid_attrs)
    end

    test "update_dummy/2 with valid data updates the dummy" do
      dummy = dummy_fixture()
      assert {:ok, dummy} = Session.update_dummy(dummy, @update_attrs)
      assert %Dummy{} = dummy
      assert dummy.lastname == "some updated lastname"
      assert dummy.name == "some updated name"
    end

    test "update_dummy/2 with invalid data returns error changeset" do
      dummy = dummy_fixture()
      assert {:error, %Ecto.Changeset{}} = Session.update_dummy(dummy, @invalid_attrs)
      assert dummy == Session.get_dummy!(dummy.id)
    end

    test "delete_dummy/1 deletes the dummy" do
      dummy = dummy_fixture()
      assert {:ok, %Dummy{}} = Session.delete_dummy(dummy)
      assert_raise Ecto.NoResultsError, fn -> Session.get_dummy!(dummy.id) end
    end

    test "change_dummy/1 returns a dummy changeset" do
      dummy = dummy_fixture()
      assert %Ecto.Changeset{} = Session.change_dummy(dummy)
    end
  end
end
