
alias TicketingSystem.Repo

alias TicketingSystem.Accounts.Role
alias TicketingSystem.Accounts.User
alias TicketingSystem.Ticketing.Ticket
alias TicketingSystem.Ticketing.Agent

defmodule Forge do
    alias TicketingSystem.Accounts.{Role, User}
    import Ecto, only: [build_assoc: 2]
    require Logger

    def build_random_users(%Role{} = role, number_of_users) do
         Enum.map(Enum.to_list(1..number_of_users) ,fn _  -> build_random_user(role) end)
    end

    def build_random_user(%Role{} = role) do
        role
        |> build_assoc(:users)
        |> User.changeset(%{email: Faker.Internet.email, name: Faker.Name.first_name, password: "password", lastname: Faker.Name.last_name, password_confirmation: "password"})
        |> Repo.insert
        |> build_author_and_asignee()
        |> build_random_tickets(20)
    end

    defp build_author_and_asignee({:ok, user}) do
        Agent.changeset(%Agent{},%{ user_id: user.id, alias: Faker.App.author})
        |> Repo.insert
        |> get_agent()
    end

    defp get_agent({:ok, agent}) do
        agent
    end

    def build_random_tickets(agent, number_of_agents) do
         Enum.map(Enum.to_list(1..number_of_agents) ,fn _  -> build_random_ticket(%Ticket{}, agent) end)
    end

    def build_random_ticket(%Ticket{} = ticket, agent) do
        ticket
        |> Ticket.changeset(%{title: Faker.Company.buzzword, body: Faker.Lorem.Shakespeare.hamlet, status: "open", author_id: agent.id, asignee_id: agent.id})
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
    pending_approval: false,
    role: admin
}

 Forge.build_random_users(operator, 50)
