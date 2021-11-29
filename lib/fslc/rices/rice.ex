defmodule Fslc.Rices.Rice do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rices" do
    field :description, :string
    field :document_id, :integer
    field :name, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(rice, attrs) do
    rice
    |> cast(attrs, [:name, :description, :document_id, :user_id])
    |> validate_required([:name, :description, :document_id, :user_id])
  end
end
