defmodule Fslc.Rices do
  @moduledoc """
  The Rices context.
  """

  import Ecto.Query, warn: false
  alias Fslc.Repo

  alias Fslc.Rices.Rice

  @doc """
  Returns the list of rices.

  ## Examples

      iex> list_rices()
      [%Rice{}, ...]

  """
  def list_rices do
    Repo.all(Rice)
  end

  @doc """
  Gets a single rice.

  Raises `Ecto.NoResultsError` if the Rice does not exist.

  ## Examples

      iex> get_rice!(123)
      %Rice{}

      iex> get_rice!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rice!(id), do: Repo.get!(Rice, id)

  @doc """
  Creates a rice.

  ## Examples

      iex> create_rice(%{field: value})
      {:ok, %Rice{}}

      iex> create_rice(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rice(attrs \\ %{}) do
    %Rice{}
    |> Rice.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a rice.

  ## Examples

      iex> update_rice(rice, %{field: new_value})
      {:ok, %Rice{}}

      iex> update_rice(rice, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rice(%Rice{} = rice, attrs) do
    rice
    |> Rice.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a rice.

  ## Examples

      iex> delete_rice(rice)
      {:ok, %Rice{}}

      iex> delete_rice(rice)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rice(%Rice{} = rice) do
    Repo.delete(rice)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rice changes.

  ## Examples

      iex> change_rice(rice)
      %Ecto.Changeset{data: %Rice{}}

  """
  def change_rice(%Rice{} = rice, attrs \\ %{}) do
    Rice.changeset(rice, attrs)
  end
end
