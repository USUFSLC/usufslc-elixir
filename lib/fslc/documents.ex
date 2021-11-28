defmodule Fslc.Documents do
  import Ecto.Query, warn: false

  alias Fslc.Repo
  alias Fslc.Documents.Upload

  def check_size(size) do
    if (size > 3000000) do
      {:error, "File is too large (>3MB)"}
    else
      :ok
    end
  end

  def list_uploads() do
    Repo.all(Upload)
  end

  def get_upload!(id) do
    Upload
    |> Repo.get!(id)
  end

  def create_upload(user_id, %Plug.Upload{
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
            hash: hash, size: size, user_id: user_id }) 
          |> Repo.insert(),
        :ok <- File.cp(
            tmp_path,
            Upload.local_path(upload.id, filename)
          )
      do
        {:ok, upload}
      else
        {:error, reason}=error -> Repo.rollback(reason)
      end
    end
  end
end