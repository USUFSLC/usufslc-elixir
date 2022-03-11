defmodule Fslc.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :question, :string
      add :poll_id, references(:polls, on_delete: :delete_all)

      timestamps()
    end

  end
end
