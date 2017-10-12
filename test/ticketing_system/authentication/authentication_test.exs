defmodule TicketingSystem.AuthenticationTests do
  use TicketingSystem.DataCase

  alias TicketingSystem.Accounts.Authentication

  describe "users" do
    alias TicketingSystem.Accounts.User

    @valid_attrs %{email: "some email", lastname: "some lastname", name: "some name", password: "some password"}
    @update_attrs %{email: "some updated email", lastname: "some updated lastname", name: "some updated name", password: "some updated password"}
    @invalid_attrs %{email: nil, lastname: nil, name: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

  end

end
