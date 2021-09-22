defmodule FslcWeb.AdminController do
  use FslcWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
