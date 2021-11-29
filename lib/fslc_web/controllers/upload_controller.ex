defmodule FslcWeb.UploadController do
  use FslcWeb, :controller
  alias Fslc.Documents
  alias Fslc.Documents.Upload
  alias Fslc.Repo
  import Ecto.Query

  def index(conn, _params) do
    uploads = Documents.list_uploads()
    render(conn, "index.html", uploads: uploads)
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def show(conn, %{"id" => id}) do
    upload = Documents.get_upload!(id)
    local_path = Upload.local_path(upload.id, upload.filename)
    send_download conn, {:file, local_path}, filename: upload.filename
  end

  defp max_upload_count() do
    40
  end

  defp can_upload(conn) do
    user = conn.assigns[:current_user]
    if !(FslcWeb.Helpers.Authorize.is_admin?(user)) do
      user_upload_count = (from x in Upload, where: x.id == ^user.id, select: x, limit: max_upload_count())
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
    end
    case Documents.create_upload(conn.assigns[:current_user].id, upload) do
      {:ok, _upload} ->
        conn
        |> put_flash(:info, "File uploaded correctly")
        |> redirect(to: Routes.upload_path(conn, :index))
      {:error, reason} ->
        conn
        |> put_flash(:error, "Error uploading file #{inspect(reason)}")
        |> render("new.html")
    end
  end
end