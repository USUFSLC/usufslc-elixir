defmodule FslcWeb.UserPageController do
  alias Fslc.Accounts
  alias Fslc.Accounts.UserNotifier
  alias Fslc.Repo
  use FslcWeb, :controller

  def index(conn, _params) do
    {status, static_user_pages} = File.ls("users")
    if (status == :ok and Enum.count(static_user_pages) > 0) do
      render(conn, "index.html", users: 
        Enum.map(static_user_pages, fn x -> String.replace(x, ".html", "") end)
        |> Enum.sort
      )
    else
      conn
      |> put_flash(:error, "Could not find any user pages")
      |> render("index.html", users: [])
    end
  end

  def user(conn, %{"username" => user} = _params) do
    path = "users/" <> user <> ".html"
    if (File.exists?(path)) do
      html(conn, File.read!(path))
    else
      conn
      |> put_flash(:error, "There is no page associated with that username")
      |> redirect(to: Routes.user_page_path(conn, :index))
      |> halt()
    end
  end

  def create_user_token(conn, _params) do
    render(conn, "create.html") 
  end

  def submit_user_page_confirm(conn, %{"data" => data} = _params) do
    user = Accounts.get_user_by_username(data["for"])

    if user do
      token = :crypto.strong_rand_bytes(20) |> Base.url_encode64 |> binary_part(0, 20)
      Accounts.create_user_page_token(%{user_id: user.id, token: token})

      UserNotifier.deliver_user_confirm_page_instructions(user, token, "https://github.com", Routes.page_url(conn, :guidelines))

      conn
      |> put_flash(:info, "Sent")
      |> redirect(to: Routes.admin_path(conn, :index))
      |> halt()
    else 
      conn
      |> put_flash(:error, "User was not found")
      |> render("create.html")
    end
  end

  def validate_user_page_form(conn, _params) do
    render(conn, "validate.html")
  end

  def validate_user_page_confirm(conn, %{"token" => token} = _params) do
    result = Accounts.get_page_token_by_token_string(token)

    if result do
      Repo.delete!(result)
      conn
      |> put_flash(:info, "Token confirmed for " <> result.user.username)
      |> put_flash(:error, "Token now invalid")
      |> render("validate.html")
    else
      conn
      |> put_flash(:error, "That token is not attached to a user.")
      |> render("validate.html")
    end
  end
end

