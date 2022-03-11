defmodule Fslc.Repo.Migrations.CreateOptions do
  use Ecto.Migration

  def change do
    create table(:options) do
      add :option, :string
      add :question_id, references(:questions, on_delete: :delete_all)

      timestamps()
    end

  end
end
