defmodule Fslc.Petitions.Petition do
  use Ecto.Schema
  import Ecto.Changeset

  schema "petitions" do
    field :email, :string
    field :name, :string
    field :token, :string
    field :validated, :boolean, default: false
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(petition, attrs) do
    petition
    |> cast(attrs, [:name, :email, :token, :validated, :title])
    |> downcase_email
    |> gen_token_if_token_empty
    |> validate_format(:email, ~r/@[a-zA-Z0-9.]*usu\.edu$/, message: "must be a valid email as a usu.edu domain or subdomain")
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
  end

  defp gen_token() do
    :crypto.strong_rand_bytes(64)
    |> Base.url_encode64
    |> binary_part(0, 64)
  end
  
  defp gen_token_if_token_empty(changeset) do
    case get_change(changeset, :token) do
      nil -> put_change(changeset, :token, gen_token())
      "" -> put_change(changeset, :token, gen_token())
      _ -> changeset
    end
  end
  

  def downcase_email(changeset) do
    update_change(changeset, :email, &String.downcase/1)
  end
end
