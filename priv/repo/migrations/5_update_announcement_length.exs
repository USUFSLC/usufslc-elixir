defmodule Fslc.Repo.Migrations.UpdateAnnouncementLength do
  use Ecto.Migration

  def change do
    alter table(:announcements) do
      modify :description, :string, size: 5000
    end
  end
end
