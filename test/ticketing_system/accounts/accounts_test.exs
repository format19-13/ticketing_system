defmodule TicketingSystem.AccountsTest do
  use TicketingSystem.DataCase

  alias TicketingSystem.Accounts
  alias TicketingSystem.TestHelper

  @user_valid_attrs %{"email" => "some@email.com", "lastname" => "some lastname", "name" => "some name",
                "password" => "some password", "password_confirmation" => "some password", "role" => %{"name" => "admin"}}


  describe "users" do
    alias TicketingSystem.Accounts.User

    @update_attrs %{"email" =>"another@email.com", "lastname" =>"some updated lastname", "name" => "some updated name",
                    "password" => "some updated password"}

    @invalid_attrs %{"email"  =>  "clearly, not an email", "name"  =>  nil, "password"  =>  nil,
                    "role" => %{"name" => "this role doesnt exists"}}

    test "list_users/0 returns all users" do
      user = TestHelper.create_user(@user_valid_attrs)
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = TestHelper.create_user(@user_valid_attrs)
      assert Accounts.get_user!(user.id).email == user.email
    end

    test "create_user/1 with valid data creates a user" do
      one_user = TestHelper.create_user(@user_valid_attrs)
      assert one_user.email == "some@email.com"
      assert one_user.lastname == "some lastname"
      assert one_user.name == "some name"
      assert one_user.password == "some password"
    end

    test "update_user/2 with valid data updates the user" do
      one_user = TestHelper.create_user(@user_valid_attrs)
      assert {:ok, one_user} = Accounts.update_user(one_user, @update_attrs)
      assert %User{} = one_user
      assert one_user.email == "another@email.com"
      assert one_user.lastname == "some updated lastname"
      assert one_user.name == "some updated name"
      assert one_user.password == "some updated password"
    end

    test "delete_user/1 deletes the user" do
      one_user = TestHelper.create_user(@user_valid_attrs)
      assert {:ok, %User{}} = Accounts.delete_user(one_user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(one_user.id) end
    end

    test "change_user/1 returns a user changeset" do
      one_user = TestHelper.create_user(@user_valid_attrs)
      assert %Ecto.Changeset{} = Accounts.change_user(one_user)
    end
  end

  describe "roles" do
    alias TicketingSystem.Accounts.Role

    @valid_attrs %{"name" => "developer"}
    @invalid_attrs %{"name" =>  "not a role"}

    def role_fixture(attrs \\ %{}) do
      {:ok, role} =
        attrs
        |> Accounts.create_role()

      role
    end

    test "list_roles/0 returns all roles" do
      role = role_fixture(@valid_attrs)
      assert Accounts.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture(@valid_attrs)
      assert Accounts.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      assert {:ok, %Role{} = role} = Accounts.create_role(@valid_attrs)
      assert role.name == "developer"
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_role(@invalid_attrs)
    end

  end


describe "sessions" do

  @valid_attrs  %{"email" => "some@email.com",  "password" => "some password"}
  @invalid_attrs  %{"email" => "jhon_doe@email.com",  "password" => "some password"}
  @invalid_attrs  %{"email" => "jhon_doe@email.com",  "password" => "some password"}

  test "creates a new user session for a valid user" do
    TestHelper.create_user(@user_valid_attrs)
    conn = TestHelper.build_dummy_conn()
    Accounts.try_to_login(conn, @valid_attrs)
    assert TestHelper.get_current_session(conn)
  end

  test "does not create a session with a bad login" do
    conn = TestHelper.build_dummy_conn()
    Accounts.try_to_login(conn, %{"email" => "some@email.com",  "password" => "not a real password"})
    refute TestHelper.get_current_session(conn)
  end

  test "does not create a session if user does not exist" do
    onn = TestHelper.build_dummy_conn()
    Accounts.try_to_login(conn, @invalid_attrs)
    refute TestHelper.get_current_session(conn)
  end
end

end
