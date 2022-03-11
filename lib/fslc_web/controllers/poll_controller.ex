defmodule FslcWeb.PollController do
  use FslcWeb, :controller
  alias Fslc.Repo

  alias Fslc.Polls
  alias Fslc.Polls.Poll
  alias Fslc.Polls.Question
  alias FslcWeb.Helpers.Authorize

  plug Authorize, %{resource: Poll} when action in [:delete, :edit, :update] 

  def index(conn, _params) do
    polls = Polls.list_polls()
    render(conn, "index.html", polls: polls)
  end

  def new(conn, _params) do
    changeset = Polls.change_poll(%Poll{questions: [%Question{}, %Question{}]})
    render(conn, "new.html", changeset: changeset)
  end

  def create(%{:assigns => %{:current_user => user}} = conn, %{"poll" => poll_params} = params) do
    case Polls.create_poll(user, poll_params) do
      {:ok, poll} ->
        conn
        |> put_flash(:info, "Poll created successfully.")
        |> redirect(to: Routes.poll_path(conn, :show, poll))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    poll = Polls.get_poll!(id)
    |> Repo.preload([questions: [options: [:votes]]])

    render(conn, "show.html", poll: poll)
  end

  def edit(conn, %{"id" => id}) do
    poll = Polls.get_poll!(id)
    |> Repo.preload(:questions)
    changeset = Polls.change_poll(poll)
    render(conn, "edit.html", poll: poll, changeset: changeset)
  end

  def update(conn, %{"id" => id, "poll" => poll_params}) do
    poll = Polls.get_poll!(id)
    |> Repo.preload(:questions)

    case Polls.update_poll(poll, poll_params) do
      {:ok, poll} ->
        conn
        |> put_flash(:info, "Poll updated successfully.")
        |> redirect(to: Routes.poll_path(conn, :show, poll))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", poll: poll, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    poll = Polls.get_poll!(id)
    {:ok, _poll} = Polls.delete_poll(poll)

    conn
    |> put_flash(:info, "Poll deleted successfully.")
    |> redirect(to: Routes.poll_path(conn, :index))
  end
end
