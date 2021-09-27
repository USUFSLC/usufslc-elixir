defmodule Fslc.Repo.Migrations.CreateAnnouncements do
  use Ecto.Migration

  def change do
    create table(:announcements) do
      add :announcement_name, :string, size: 40
      add :description, :string, size: 1000
      add :publish_date, :naive_datetime, default: fragment("(now() + interval '7 days')")
    end
  end
end
