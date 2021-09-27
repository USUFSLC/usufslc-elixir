defmodule Fslc.AnnouncementUpdater do
  use GenServer
  import Ecto.Query
  alias Fslc.Repo
  alias Fslc.Announcement

  defp update_time do
    # In ms
    60 * 1000
  end

  defp send_discord(text) do
    :httpc.request(:post,
      {
        System.get_env("DISCORD_WEBHOOK_URL"), [],
        'application/json',
        %{content: text} |> Jason.encode!
      }, [], [])
  end

  defp update_announcements() do
    query = from x in Announcement, where: x.publish_date < fragment("now()"), select: x

    Repo.all(query)
    |> Enum.map(fn announcement -> send_discord(announcement.description) end)

    Repo.delete_all(query)
  end


  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    update_announcements()

    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, update_time())
  end
end
