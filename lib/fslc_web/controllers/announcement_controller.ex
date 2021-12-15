defmodule FslcWeb.AnnouncementController do
  alias Fslc.Announcement
  alias Fslc.Repo
  use FslcWeb, :controller
  import Ecto.Query

  def index(conn, _params) do
    announcements = (from a in Announcement, select: a, order_by: a.publish_date)
    |> Repo.all

    render(conn, "index.html", announcements: announcements)
  end

  def new(conn, _params) do
    changeset = Announcement.changeset(%Announcement{description: "Hello, @everyone..."})
    render(conn, "new.html", changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    announcement = (from x in Announcement, where: x.id == ^id, select: x)
    |> Repo.one
    render(conn, "announcement.html", announcement: announcement)
  end

  def edit(conn, %{"id" => id}) do
    announcement = (from x in Announcement, where: x.id == ^id, select: x)
    |> Repo.one

    render(conn, "edit.html", changeset: Announcement.changeset(announcement), announcement: announcement)
  end

  def delete(conn, %{"id" => id}) do
    (from x in Announcement, where: x.id == ^id, select: x)
    |> Repo.delete_all

    conn
    |> put_flash(:error, "Announcement deleted")
    |> redirect(to: Routes.announcement_path(conn, :index))
    |> halt()
  end

  def create(conn, %{"announcement" => announcement_params}) do
    new_ann = Announcement.changeset(%Announcement{}, announcement_params)
    |> Repo.insert

    case new_ann do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Added new announcement")
        |> redirect(to: Routes.announcement_path(conn, :index))
        |> halt()

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "announcement" => announcement_params}) do
    announcement = (from x in Announcement, where: x.id == ^id, select: x) |> Repo.one
    changeset = Announcement.changeset(announcement, announcement_params)

    updated = changeset
    |> Repo.update

    case updated do
      {:ok, a} ->
        conn
        |> put_flash(:info, "Updated Announcement")
        |> redirect(to: Routes.announcement_path(conn, :show, a.id))
        |> halt()

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", announcement: announcement, changeset: changeset)
    end
  end
end
