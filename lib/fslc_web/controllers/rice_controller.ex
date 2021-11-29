defmodule FslcWeb.RiceController do
  use FslcWeb, :controller

  alias Fslc.Rices
  alias Fslc.Rices.Rice

  def index(conn, _params) do
    rices = Rices.list_rices()
    render(conn, "index.html", rices: rices)
  end

  def new(conn, _params) do
    changeset = Rices.change_rice(%Rice{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"rice" => rice_params}) do
    case Rices.create_rice(rice_params) do
      {:ok, rice} ->
        conn
        |> put_flash(:info, "Rice created successfully.")
        |> redirect(to: Routes.rice_path(conn, :show, rice))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    rice = Rices.get_rice!(id)
    |> Repo.preload(:user)
    render(conn, "show.html", rice: rice)
  end

  def edit(conn, %{"id" => id}) do
    rice = Rices.get_rice!(id)
    changeset = Rices.change_rice(rice)
    render(conn, "edit.html", rice: rice, changeset: changeset)
  end

  def update(conn, %{"id" => id, "rice" => rice_params}) do
    rice = Rices.get_rice!(id)

    case Rices.update_rice(rice, rice_params) do
      {:ok, rice} ->
        conn
        |> put_flash(:info, "Rice updated successfully.")
        |> redirect(to: Routes.rice_path(conn, :show, rice))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", rice: rice, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    rice = Rices.get_rice!(id)
    {:ok, _rice} = Rices.delete_rice(rice)

    conn
    |> put_flash(:info, "Rice deleted successfully.")
    |> redirect(to: Routes.rice_path(conn, :index))
  end
end
