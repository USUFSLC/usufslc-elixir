defmodule Fslc.Polls.Option do
  use Ecto.Schema
  import Ecto.Changeset

  schema "options" do
    field :option, :string
    belongs_to :question, Fslc.Polls.Question
    has_many :votes, Fslc.Polls.Vote, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(option, attrs) do
    option
    |> cast(attrs, [:option])
    |> validate_required([:option])
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
