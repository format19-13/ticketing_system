defmodule TicketingSystem.Forge do
    alias TicketingSystem.Accounts.{Role, User}
    import Ecto, only: [build_assoc: 2]

    def build_random_users(%Role{} = role, number_of_users) do
        def role_list = Enum.map(Enum.to_list 1..number_of_users, fn _ -> role end)
         Enum.map(role_list , register_user(role))
    end

    def build_random_user(%Role{} = role) do
        role
        |> build_assoc(:users)
        |> User.changeset(%{email: Sequence.next(:email, &"test#{&1}@example.com"), name: Faker.Name.first_name, password: "password", lastname: Faker.Name.last_name, password_confirmation: "password"})
        |> Repo.insert
    end
end
