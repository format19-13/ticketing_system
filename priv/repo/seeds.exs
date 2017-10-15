
alias TicketingSystem.Repo

alias TicketingSystem.Accounts.Role
alias TicketingSystem.Accounts.User

defmodule Forge do
    alias TicketingSystem.Accounts.{Role, User}
    import Ecto, only: [build_assoc: 2]

    def build_random_users(%Role{} = role, number_of_users) do
         Enum.map(Enum.to_list(1..number_of_users) ,fn _  -> build_random_user(role) end)
    end

    def build_random_user(%Role{} = role) do
        role
        |> build_assoc(:users)
        |> User.changeset(%{email: Faker.Internet.email, name: Faker.Name.first_name, password: "password", lastname: Faker.Name.last_name, password_confirmation: "password"})
        |> Repo.insert
    end
end


admin = Repo.insert! %Role{
    name: "admin"
}

operator = Repo.insert! %Role{
    name: "operator"
}

Repo.insert! %Role{
    name: "developer"
}

Repo.insert! %User{
    name: "root",
    email: "simple@email.com",
    password: "root",
    is_active: true,
    role: admin
}

 Forge.build_random_users(operator, 5)
