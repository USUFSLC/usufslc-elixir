defmodule Fslc.Repo.Migrations.UpdateAnnouncementLength do
  use Ecto.Migration

  def change do
    alter table(:announcements) do
      modify :name, :string, size: 120
    end
  end
end
