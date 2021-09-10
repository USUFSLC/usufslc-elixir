defmodule Fslc.Repo.Migrations.CreateAccountRoles do
  use Ecto.Migration

  def change do
    create table(:account_roles) do
      add :title, :string

      timestamps()
    end

  end
end
