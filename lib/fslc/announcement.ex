defmodule Fslc.Announcement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "announcements" do
    field :announcement_name, :string, size: 40
    field :description, :string, size: 5000
    field :publish_date, :naive_datetime
  end

  @doc false
  def changeset(role, attrs \\ %{}) do
    role
    |> cast(attrs, [:announcement_name, :description, :publish_date])
    |> validate_length(:description, max: 5000)
    |> validate_required([:description, :publish_date])
  end
end
