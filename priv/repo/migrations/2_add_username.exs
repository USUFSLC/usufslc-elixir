defmodule Fslc.Repo.Migrations.CreateUsersAuthTables do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :text
    end

    create unique_index(:users, [:username])
  end
end
