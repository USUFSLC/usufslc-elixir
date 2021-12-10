defmodule Fslc.Rices.Rice do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rices" do
    field :description, :string
    field :name, :string
    field :document_id, :integer
    belongs_to :user, Fslc.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(rice, attrs) do
    rice
    |> cast(attrs, [:name, :description, :document_id])
    |> validate_required([:name, :description, :document_id])
  end
end
