defmodule Fslc.Documents do
  import Ecto.Query, warn: false

  alias Fslc.Repo
  alias Fslc.Documents.Upload

  def check_size(size) do
    if (size > 15000000) do
      {:error, "File is too large (>15MB)"}
    else
      :ok
    end
  end

  def list_uploads() do
    Repo.all(Upload)
    |> Enum.map(fn x -> Repo.preload(x, :user) end)
  end

  def list_uploads_by_user_id(user_id) do
    Repo.all(from x in Upload, where: x.user_id == ^user_id, select: x)
  end

  def list_images_by_user_id(user_id) do
    list_uploads_by_user_id(user_id)
    |> Enum.filter(fn x -> is_image?(x.id) end)
  end

  def get_upload!(id) do
    Upload
    |> Repo.get!(id)
  end

  def is_image?(id) do
    upload = Upload
    |> Repo.get!(id)
    String.match?(upload.content_type, ~r/image/)
  end

  def delete_upload!(id) do
    doc = get_upload!(id)
    File.rm!(Upload.local_path(id, doc.filename))
    Repo.delete!(doc)
  end

  def create_upload(user, %Plug.Upload{
          filename: filename,
          path: tmp_path,
          content_type: content_type
        }) do
		hash = File.stream!(tmp_path, [], 2048) 
          |> Upload.sha256()
    Repo.transaction fn ->
      with {:ok, %File.Stat{size: size}} <- File.stat(tmp_path),  
        :ok <- check_size(size),
        {:ok, upload} <- 
          %Upload{} |> Upload.changeset(%{
            filename: filename, content_type: content_type,
            hash: hash, size: size}) 
          |> Ecto.Changeset.put_assoc(:user, user)
          |> Repo.insert(),
        :ok <- File.cp(
            tmp_path,
            Upload.local_path(upload.id, filename)
          )
      do
        {:ok, upload}
      else
        {:error, reason}=_error -> Repo.rollback(reason)
      end
    end
  end
end