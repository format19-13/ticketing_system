defmodule TicketingSystem.AuthenticationTest do
  use TicketingSystem.DataCase

  alias TicketingSystem.Authentication

  describe "dummies" do
    alias TicketingSystem.Authentication.Dummy

    @valid_attrs %{lastname: "some lastname", name: "some name"}
    @update_attrs %{lastname: "some updated lastname", name: "some updated name"}
    @invalid_attrs %{lastname: nil, name: nil}

    def dummy_fixture(attrs \\ %{}) do
      {:ok, dummy} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Authentication.create_dummy()

      dummy
    end

    test "list_dummies/0 returns all dummies" do
      dummy = dummy_fixture()
      assert Authentication.list_dummies() == [dummy]
    end

    test "get_dummy!/1 returns the dummy with given id" do
      dummy = dummy_fixture()
      assert Authentication.get_dummy!(dummy.id) == dummy
    end

    test "create_dummy/1 with valid data creates a dummy" do
      assert {:ok, %Dummy{} = dummy} = Authentication.create_dummy(@valid_attrs)
      assert dummy.lastname == "some lastname"
      assert dummy.name == "some name"
    end

    test "create_dummy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authentication.create_dummy(@invalid_attrs)
    end

    test "update_dummy/2 with valid data updates the dummy" do
      dummy = dummy_fixture()
      assert {:ok, dummy} = Authentication.update_dummy(dummy, @update_attrs)
      assert %Dummy{} = dummy
      assert dummy.lastname == "some updated lastname"
      assert dummy.name == "some updated name"
    end

    test "update_dummy/2 with invalid data returns error changeset" do
      dummy = dummy_fixture()
      assert {:error, %Ecto.Changeset{}} = Authentication.update_dummy(dummy, @invalid_attrs)
      assert dummy == Authentication.get_dummy!(dummy.id)
    end

    test "delete_dummy/1 deletes the dummy" do
      dummy = dummy_fixture()
      assert {:ok, %Dummy{}} = Authentication.delete_dummy(dummy)
      assert_raise Ecto.NoResultsError, fn -> Authentication.get_dummy!(dummy.id) end
    end

    test "change_dummy/1 returns a dummy changeset" do
      dummy = dummy_fixture()
      assert %Ecto.Changeset{} = Authentication.change_dummy(dummy)
    end
  end
end
