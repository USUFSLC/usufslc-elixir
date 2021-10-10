defmodule Fslc.Repo.Migrations.CreateUserPageTokens do
  use Ecto.Migration

  def change do
    create table(:user_page_tokens) do
      add :user_id, references(:users)
      add :token, :string
    end
  end
end
