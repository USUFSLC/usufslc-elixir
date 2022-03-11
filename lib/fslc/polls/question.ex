defmodule Fslc.Polls.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :question, :string
    has_many :options, Fslc.Polls.Option
    belongs_to :poll, Fslc.Polls.Poll
    field :delete, :boolean, virtual: true

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:question, :delete])
    |> validate_required([:question])
    |> cast_assoc(:options)
    |> maybe_mark_for_deletion
  end

  defp maybe_mark_for_deletion(changeset) do
    if get_change(changeset, :delete) do
      %{changeset | action: :delete}
    else
      changeset
    end
  end
end
