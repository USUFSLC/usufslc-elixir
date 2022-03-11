defmodule Fslc.Polls.Poll do
  use Ecto.Schema
  import Ecto.Changeset

  schema "polls" do
    field :name, :string
    field :closed, :boolean
    belongs_to :user, Fslc.Accounts.User
    has_many :questions, Fslc.Polls.Question

    timestamps()
  end

  @doc false
  def changeset(poll, attrs) do
    poll
    |> cast(attrs, [:name])
    |> cast_assoc(:questions, with: &Fslc.Polls.Question.changeset/2)
    |> validate_required([:name])
  end
end
