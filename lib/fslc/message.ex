defmodule Fslc.Message do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Fslc.Repo

  schema "messages" do
    field :content, :string

    belongs_to :user, Fslc.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content])
    |> put_assoc(:user, attrs["user"])
    |> validate_required([:content])
  end

  def list_by_earliest() do
    (from x in Fslc.Message, order_by: x.inserted_at, select: x)
    |> Repo.all()
    |> Repo.preload(:user)
  end
end
