defmodule TicketingSystem.RegistrationsTest do
  use TicketingSystem.DataCase

  alias TicketingSystem.{ Accounts, Ticketing, Registrations, Repo}
  alias TicketingSystem.TestHelper
  @timestamps_opts [usec: Mix.env != :test]


  describe "registrations" do
    alias TicketingSystem.Accounts.User
    alias TicketingSystem.Ticketing.Agent

    @user_valid_attrs %{"email" => "some@email.com", "lastname" => "some lastname", "name" => "some name",
                  "password" => "some password", "password_confirmation" => "some password", "role" => %{"name" => "admin"}}

    @invalid_attrs %{"email"  =>  "clearly, not an email", "name"  =>  nil, "password"  =>  nil,
                    "role" => %{"name" => "this role doesnt exists"}}

    test "register user with valid data creates a user and an agent" do
      {:ok, one_user} = Registrations.register_user(@user_valid_attrs)
      assert one_user.email == "some@email.com"
      assert one_user.lastname == "some lastname"
      assert one_user.name == "some name"
      assert one_user.password == "some password"
      assert Repo.get_by!(Agent, user_id: one_user.id)
    end

    test "register user with invalid data returns changeset" do
      {:ok, one_user} = Registrations.register_user(@user_valid_attrs)
      assert one_user.email == "some@email.com"
      assert one_user.lastname == "some lastname"
      assert one_user.name == "some name"
      assert one_user.password == "some password"
      assert Repo.get_by!(Agent, user_id: one_user.id)
    end


  end
end
