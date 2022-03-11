defmodule Fslc.Polls.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :question, :string
    has_many :options, Fslc.Polls.Option
    belongs_to :poll, Fslc.Polls.Poll

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:question])
    |> validate_required([:question])
  end
end
