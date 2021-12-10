defmodule Fslc.Repo.Migrations.CreateUploads do
  use Ecto.Migration

  def change do
    create table(:uploads) do
      add :filename, :string
      add :size, :bigint
      add :content_type, :string
      add :hash, :string, size: 64
      add :user_id, references(:users)

      timestamps()
    end
  end
end
