defmodule FslcWeb.LivestreamController do
  alias Fslc.Repo
  alias Fslc.Message
  import Ecto.Query
  import Plug.Conn
  use FslcWeb, :controller

  defp delete_old_streams() do
    from(stream in Fslc.Livestream, where: stream.expiration < fragment("now()"))
    |> Repo.delete_all
  end

  def index(conn, _params) do
    conn
    |> put_flash(:info, "NOTICE: Your stream is most likely muted when autoplaying.")
    |> render("index.html", chats: Message.list_by_earliest())
  end

  def create(conn, _params) do
    livestream = %Fslc.Livestream{
      hash: :crypto.strong_rand_bytes(64) |> Base.encode16 |> binary_part(0, 64)
    }
    Repo.insert!(livestream)
    conn
    |> put_flash(:info, "Stream key (valid for 60 seconds): " <> livestream.hash)
    |> render("index.html", chats: Message.list_by_earliest())
  end

  def authenticate(conn, params) do
    delete_old_streams()

    exists = from(user_stream in Fslc.Livestream, where: (user_stream.expiration >= fragment("now()") and user_stream.hash == ^params["hash"]), select: user_stream)
    |> Repo.delete_all
    |> elem(0)

    if exists > 0 do
      conn
      |> put_status(:ok)
      |> put_flash(:info, "Authenticated to stream")
      |> render("index.html")
    else
      conn
      |> put_status(:unauthorized)
      |> put_flash(:error, "Unauthorized")
      |> render("index.html")
    end
  end
end
