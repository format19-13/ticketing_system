defmodule TicketingSystem.TicketsTest do
  use TicketingSystem.DataCase

  alias TicketingSystem.Tickets

  describe "agents" do
    alias TicketingSystem.Tickets.Agent

    @valid_attrs %{lastname: "some lastname", name: "some name", role: "some role"}
    @update_attrs %{lastname: "some updated lastname", name: "some updated name", role: "some updated role"}
    @invalid_attrs %{lastname: nil, name: nil, role: nil}

    def agent_fixture(attrs \\ %{}) do
      {:ok, agent} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tickets.create_agent()

      agent
    end

    test "list_agents/0 returns all agents" do
      agent = agent_fixture()
      assert Tickets.list_agents() == [agent]
    end

    test "get_agent!/1 returns the agent with given id" do
      agent = agent_fixture()
      assert Tickets.get_agent!(agent.id) == agent
    end

    test "create_agent/1 with valid data creates a agent" do
      assert {:ok, %Agent{} = agent} = Tickets.create_agent(@valid_attrs)
      assert agent.lastname == "some lastname"
      assert agent.name == "some name"
      assert agent.role == "some role"
    end

    test "create_agent/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tickets.create_agent(@invalid_attrs)
    end

    test "update_agent/2 with valid data updates the agent" do
      agent = agent_fixture()
      assert {:ok, agent} = Tickets.update_agent(agent, @update_attrs)
      assert %Agent{} = agent
      assert agent.lastname == "some updated lastname"
      assert agent.name == "some updated name"
      assert agent.role == "some updated role"
    end

    test "update_agent/2 with invalid data returns error changeset" do
      agent = agent_fixture()
      assert {:error, %Ecto.Changeset{}} = Tickets.update_agent(agent, @invalid_attrs)
      assert agent == Tickets.get_agent!(agent.id)
    end

    test "delete_agent/1 deletes the agent" do
      agent = agent_fixture()
      assert {:ok, %Agent{}} = Tickets.delete_agent(agent)
      assert_raise Ecto.NoResultsError, fn -> Tickets.get_agent!(agent.id) end
    end

    test "change_agent/1 returns a agent changeset" do
      agent = agent_fixture()
      assert %Ecto.Changeset{} = Tickets.change_agent(agent)
    end
  end
end
