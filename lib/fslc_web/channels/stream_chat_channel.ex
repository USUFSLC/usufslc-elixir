defmodule FslcWeb.StreamChatChannel do
  use FslcWeb, :channel
  alias Fslc.Message
  alias Fslc.Repo

  @impl true
  def join("stream_chat:lobby", payload, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_in("shout", payload, socket) do
    if (socket.assigns) do
      # We can check if the message came from a user since to reach here a person
      # must be signed in with an assigns on their socket
      {:error, %{reason: "Only server can shout"}}
    else
      broadcast socket, "shout", payload
      {:noreply, socket}
    end
  end

  @impl true
  def handle_in("send", payload, socket) do
    if String.length(payload["body"]) != 0 do
      IO.puts(String.length(payload["body"]))
      message = %Message{ content: payload["body"] } 
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.put_assoc(:user, socket.assigns.user)
      |> Repo.insert!()
      payload = Map.merge(payload, %{"name" => socket.assigns.user.username, "id" => message.id})
      broadcast socket, "shout", payload
    end
    {:noreply, socket}
  end
end
