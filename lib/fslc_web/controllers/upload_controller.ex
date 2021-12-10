defmodule FslcWeb.UploadController do
  use FslcWeb, :controller
  alias Fslc.Documents
  alias Fslc.Documents.Upload
  alias Fslc.Repo
  alias FslcWeb.Helpers.Authorize
  import Ecto.Query

  plug Authorize, %{resource: Upload} when action in [:delete] 

  def index(conn, _params) do
    if Authorize.is_admin?(conn.assigns[:current_user]) do
      render(conn, "index.html", uploads: Documents.list_uploads())
    else
      render(conn, "index.html", uploads: Documents.list_uploads_by_user_id(conn.assigns[:current_user].id))
    end
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def show(conn, %{"id" => id}) do
    upload = Documents.get_upload!(id)
    local_path = Upload.local_path(upload.id, upload.filename)
    send_download conn, {:file, local_path}, filename: upload.filename
  end

  def delete(conn, %{"id" => id}) do
    Documents.delete_upload!(id)
    conn
    |> put_flash(:info, "Upload deleted successfully.")
    |> redirect(to: Routes.upload_path(conn, :index))
    |> halt()
  end

  defp max_upload_count() do
    40
  end

  defp can_upload(conn) do
    user = conn.assigns[:current_user]
    if !(FslcWeb.Helpers.Authorize.is_admin?(user)) do
      user_upload_count = (from x in Upload, where: x.id == ^user.id, select: x)
      |> Repo.all()
      |> Enum.count()

      !!(user_upload_count < max_upload_count())
    else
      true
    end
  end

  def create(conn, %{"upload" => %Plug.Upload{}=upload}) do
    if !(can_upload(conn)) do
      conn
      |> put_flash(:error, "Error uploading file \"User can no longer upload any more files (maybe you've uploaded more than #{max_upload_count()} times)\"")
      |> render("new.html")
      |> halt()
    end
    case Documents.create_upload(conn.assigns[:current_user], upload) do
      {:ok, _upload} ->
        conn
        |> put_flash(:info, "File uploaded successfully")
        |> redirect(to: Routes.upload_path(conn, :index))
        |> halt()
      {:error, reason} ->
        conn
        |> put_flash(:error, "Error uploading file #{inspect(reason)}")
        |> render("new.html")
    end
  end
end