defmodule FslcWeb.RiceController do
  use FslcWeb, :controller

  alias Fslc.Repo
  alias Fslc.Rices
  alias Fslc.Rices.Rice
  alias FslcWeb.Helpers.Authorize

  plug Authorize, %{resource: Rice} when action in [:delete, :edit, :update] 

  def max_rice_count() do
    5
  end

  def index(conn, _params) do
    rices = Rices.list_rices()
    render(conn, "index.html", rices: rices)
  end

  def new(conn, _params) do
    changeset = Rices.change_rice(%Rice{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"rice" => rice_params}) do
    user_num_rices = Rices.list_rices_by_user_id(conn.assigns[:current_user].id)
    |> Enum.count()
    if user_num_rices < max_rice_count() || Authorize.is_admin?(conn.assigns[:current_user]) do
      case Rices.create_rice(conn.assigns[:current_user], rice_params) do
        {:ok, rice} ->
          conn
          |> put_flash(:info, "Rice created successfully.")
          |> redirect(to: Routes.rice_path(conn, :show, rice))
          |> halt()

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    else
      conn
      |> put_flash(:error, "You can only upload " <> Integer.to_string(max_rice_count()) <> " rices")
      |> redirect(to: Routes.rice_path(conn, :new))
      |> halt()
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
