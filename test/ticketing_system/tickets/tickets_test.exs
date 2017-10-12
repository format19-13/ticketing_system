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


  end
end
