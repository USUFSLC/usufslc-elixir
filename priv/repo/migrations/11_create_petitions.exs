defmodule Fslc.Repo.Migrations.CreatePetitions do
  use Ecto.Migration

  def change do
    create table(:petitions) do
      add :name, :string
      add :email, :string
      add :token, :string
      add :validated, :boolean

      timestamps()
    end

    create unique_index(:petitions, [:token])
    create unique_index(:petitions, [:email])
  end
end
