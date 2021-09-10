defmodule Fslc.Accounts.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "account_roles" do
    field :title, :string

    has_many :accounts, Fslc.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
