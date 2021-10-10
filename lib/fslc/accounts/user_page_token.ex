defmodule Fslc.Accounts.UserPageToken do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_page_tokens" do
    field :token, :string
    belongs_to :user, Fslc.Accounts.User
  end

  def changeset(user_page_token, attrs) do
    user_page_token
    |> cast(attrs, [:token, :user_id])
    |> validate_required([:token, :user_id])
  end
end