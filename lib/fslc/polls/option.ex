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
    |> cast_assoc(attrs, [:question])
    |> validate_required([:option])
  end
end
