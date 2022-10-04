defmodule FslcWeb.PetitionController do
  use FslcWeb, :controller

  alias Fslc.Petitions
  alias Fslc.Petitions.Petition
  alias Fslc.Petitions.PetitionNotifier
  
  def index(conn, _params) do
    petitions = Petitions.list_petitions()
    render(conn, "index.html", petitions: petitions)
  end

  def validate_petition_token(conn, %{"token" => token}) do
    case Petitions.confirm(token) do
      {:ok, petition} ->
        render(conn, "thanks.html", petition: petition)
      :error ->
        conn
        |> put_flash(:error, "Could not validate that token")
        |> render("new.html", changeset: Petitions.change_petition(%Petition{}))
    end
  end

  def new(conn, _params) do
    changeset = Petitions.change_petition(%Petition{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"petition" => petition_params}) do
    case Petitions.create_petition(petition_params) do
      {:ok, petition} ->
        PetitionNotifier.deliver_confirmation_instructions(petition.name, petition.email, Routes.petition_url(conn, :validate_petition_token, %{token: petition.token}))
        render(conn, "thanks.html", petition: petition)
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    petition = Petitions.get_petition!(id)
    render(conn, "show.html", petition: petition)
  end

  def edit(conn, %{"id" => id}) do
    petition = Petitions.get_petition!(id)
    changeset = Petitions.change_petition(petition)
    render(conn, "edit.html", petition: petition, changeset: changeset)
  end

  def update(conn, %{"id" => id, "petition" => petition_params}) do
    petition = Petitions.get_petition!(id)

    case Petitions.update_petition(petition, petition_params) do
      {:ok, petition} ->
        conn
        |> put_flash(:info, "Petition updated successfully.")
        |> redirect(to: Routes.petition_path(conn, :show, petition))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", petition: petition, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    petition = Petitions.get_petition!(id)
    {:ok, _petition} = Petitions.delete_petition(petition)

    conn
    |> put_flash(:info, "Petition deleted successfully.")
    |> redirect(to: Routes.petition_path(conn, :index))
  end
end
