defmodule Fslc.Repo.Migrations.UpdateAnnouncementLength do
  use Ecto.Migration

  def change do
    alter table(:announcements) do
      modify :announcement_name, :string, size: 120
    end
  end
end
