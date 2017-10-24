defmodule TicketingSystem.TicketingTest do

  use TicketingSystem.DataCase
  alias TicketingSystem.Ticketing.Ticket
  alias TicketingSystem.TestHelper
  alias TicketingSystem.Ticketing


  describe "tickets" do

    @valid_attrs %{body: "some body", status: "open", title: "some title"}
    @update_attrs %{body: "some updated body", status: "closed", title: "some updated title"}
    @invalid_attrs %{body: nil, status: "this aint a status", title: nil}

    test "list_tickets/0 returns all tickets" do
      ticket = TestHelper.create_ticket(@valid_attrs)
      assert Ticketing.list_tickets() == [ticket]
    end

    test "get_ticket!/1 returns the ticket with given id" do
      ticket = TestHelper.create_ticket(@valid_attrs)
      assert Ticketing.get_ticket!(ticket.id) == ticket
    end

    test "create_ticket/1 with valid data creates a ticket" do
      {:ok, agent} = TestHelper.create_agent()
      assert {:ok, %Ticket{} = ticket} = Ticketing.create_ticket(Map.merge(@valid_attrs, %{author_id: agent.id, asignee_id: agent.id}))
      assert ticket.body == "some body"
      assert ticket.status == "open"
      assert ticket.title == "some title"
    end

    test "create_ticket/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ticketing.create_ticket(@invalid_attrs)
    end

    test "update_ticket/2 with valid data updates the ticket" do
      ticket = TestHelper.create_ticket(@valid_attrs)
      assert {:ok, ticket} = Ticketing.update_ticket(ticket, @update_attrs)
      assert %Ticket{} = ticket
      assert ticket.body == "some updated body"
      assert ticket.status == "closed"
      assert ticket.title == "some updated title"
    end

    test "update_ticket/2 with invalid data returns error changeset" do
      ticket = TestHelper.create_ticket(@valid_attrs)
      assert {:error, %Ecto.Changeset{}} = Ticketing.update_ticket(ticket, @invalid_attrs)
      assert ticket == Ticketing.get_ticket!(ticket.id)
    end

    test "change_ticket/1 returns a ticket changeset" do
      ticket = TestHelper.create_ticket(@valid_attrs)
      assert %Ecto.Changeset{} = Ticketing.change_ticket(ticket)
    end
  end
end
