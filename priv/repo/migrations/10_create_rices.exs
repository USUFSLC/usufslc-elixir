defmodule Fslc.Repo.Migrations.CreateRices do
  use Ecto.Migration

  def change do
    create table(:rices) do
      add :name, :string
      add :description, :string
      add :document_id, :integer
      add :user_id, references(:users)

      timestamps()
    end
  end
end
