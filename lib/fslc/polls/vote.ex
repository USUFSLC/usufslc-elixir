defmodule Fslc.Polls.Vote do
  use Ecto.Schema

  schema "votes" do
    belongs_to :option, Fslc.Polls.Option 
    belongs_to :user, Fslc.Accounts.User

    timestamps()
  end
end
