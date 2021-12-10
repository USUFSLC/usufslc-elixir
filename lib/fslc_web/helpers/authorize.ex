defmodule FslcWeb.Helpers.Authorize do
  use Phoenix.Controller
  alias Fslc.Repo
  import Plug.Conn
  import Ecto.Query
  def init(opts) do
    opts
  end
 
  def is_admin?(user) do
    user = user |> Repo.preload(:role)
    !is_nil(user) && user.role.title == "admin"
  end

  def call(conn, opts \\ %{}) do
    user = conn.assigns[:current_user]
    %Plug.Conn{params: %{"id" => resource_id}} = conn
    resource = Repo.one(from x in Map.fetch!(opts, :resource), where: x.id == ^resource_id)
    if is_admin?(user) || resource.user_id == user.id do
      conn
    else
      conn
      |> put_flash(:error, "You are not authorized to do that.")
      |> redirect(to: NavigationHistory.last_path(conn))
      |> halt()
    end
  end
end