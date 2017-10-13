
alias TicketingSystem.Repo

alias TicketingSystem.Accounts.Role
alias TicketingSystem.Accounts.User

admin = Repo.insert! %Role{
    name: "admin"
}

Repo.insert! %Role{
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
