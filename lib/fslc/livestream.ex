defmodule Fslc.Livestream do
  use Ecto.Schema
  import Ecto.Changeset

  schema "livestreams" do
    field :hash, :string, size: 64
    field :expiration, :naive_datetime
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:hash, :expiration])
  end
end
