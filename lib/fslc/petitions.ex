defmodule Fslc.Petitions do
  @moduledoc """
  The Petitions context.
  """

  import Ecto.Query, warn: false
  alias Fslc.Repo

  alias Fslc.Petitions.Petition

  @doc """
  Returns the list of petitions.

  ## Examples

      iex> list_petitions()
      [%Petition{}, ...]

  """
  def list_petitions do
    Repo.all(Petition)
  end

  @doc """
  Gets a single petition.

  Raises `Ecto.NoResultsError` if the Petition does not exist.

  ## Examples

      iex> get_petition!(123)
      %Petition{}

      iex> get_petition!(456)
      ** (Ecto.NoResultsError)

  """
  def get_petition!(id), do: Repo.get!(Petition, id)

  @doc """
  Creates a petition.

  ## Examples

      iex> create_petition(%{field: value})
      {:ok, %Petition{}}

      iex> create_petition(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_petition(attrs \\ %{}) do
    %Petition{}
    |> Petition.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a petition.

  ## Examples

      iex> update_petition(petition, %{field: new_value})
      {:ok, %Petition{}}

      iex> update_petition(petition, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_petition(%Petition{} = petition, attrs) do
    petition
    |> Petition.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a petition.

  ## Examples

      iex> delete_petition(petition)
      {:ok, %Petition{}}

      iex> delete_petition(petition)
      {:error, %Ecto.Changeset{}}

  """
  def delete_petition(%Petition{} = petition) do
    Repo.delete(petition)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking petition changes.

  ## Examples

      iex> change_petition(petition)
      %Ecto.Changeset{data: %Petition{}}

  """
  def change_petition(%Petition{} = petition, attrs \\ %{}) do
    Petition.changeset(petition, attrs)
  end

  def confirm(token) do
    with %Petition{} = petition <- Repo.one(from x in Petition, where: x.token == ^token, select: x),
    {:ok, validatedPetition} <- petition |> Petition.changeset(%{validated: true}) |> Repo.update do
      {:ok, validatedPetition}
    else
      _ -> :error
    end
  end
end
