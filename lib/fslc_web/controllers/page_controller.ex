defmodule FslcWeb.PageController do
  use FslcWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def license(conn, _params) do
    render(conn, "license.html")
  end

  def disclaimer(conn, _params) do
    render(conn, "disclaimer.html")
  end

end
