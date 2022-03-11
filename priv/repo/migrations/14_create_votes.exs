defmodule Fslc.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :option_id, references(:options, on_delete: :delete_all)

      timestamps()
    end

  end
end
