defmodule Fslc.Repo.Migrations.AddAccountRoles do
  import Ecto.Query
  use Ecto.Migration
  alias Fslc.Repo

  def up do
    Repo.insert(%Fslc.Accounts.Role{
      title: "default",
      id: 1
    })
    Repo.insert(%Fslc.Accounts.Role{
      title: "admin",
      id: 2
    })
  end

  def down do
    from(x in Fslc.Accounts.Role, select: x)
    |> Repo.delete_all
  end
end
