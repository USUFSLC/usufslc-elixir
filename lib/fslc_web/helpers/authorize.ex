defmodule FslcWeb.Helpers.Authorize do
  import Plug.Conn
  alias Fslc.Repo
  def is_admin?(user) do
    user = user |> Repo.preload(:role)
    user.role.title == "admin"
  end
end
