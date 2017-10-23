
alias TicketingSystem.Repo
alias TicketingSystem.Accounts.{Role, User}


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

TicketingSystem.Utils.Forge.build_random_users(operator, 50)
