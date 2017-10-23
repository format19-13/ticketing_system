defmodule TicketingSystem.Utils.Forge do
    alias TicketingSystem.Repo
    alias TicketingSystem.Accounts.{Role, User}
    alias TicketingSystem.Ticketing.{Agent, Ticket}

    import Ecto, only: [build_assoc: 2]

    def build_random_users(%Role{} = role, number_of_users) do
         Enum.map(Enum.to_list(1..number_of_users) ,fn _  -> build_random_user_with_tickets(role) end)
    end

    def build_random_user_with_tickets(%Role{} = role) do
        role
        |> build_random_user()
        |> build_author_and_asignee()
        |> build_random_tickets(40)
    end

    def build_random_user(%Role{} = role) do
        role
        |> build_assoc(:users)
        |> User.changeset(%{email: Faker.Internet.email, name: Faker.Name.first_name, password: "password", lastname: Faker.Name.last_name, password_confirmation: "password"})
        |> Repo.insert
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
