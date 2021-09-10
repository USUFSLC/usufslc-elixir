roles = [
  %{
    id: 1,
    title: "user"
  },
  %{
    id: 2,
    title: "admin"
  }
]

Enum.map(roles, fn z -> Fslc.Repo.insert!(struct(%Fslc.Accounts.Role{}, z)) end)
