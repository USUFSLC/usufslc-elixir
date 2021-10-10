defmodule Fslc.Accounts.UserNotifier do
  use Phoenix.Swoosh, view: FslcWeb.EmailView, layout: {FslcWeb.LayoutView, :email}

  alias Fslc.Mailer

  defp new_info_email(user, subject) do
    new()
    |> from({"FSLC Info", "info@usufslc.com"})
    |> to({user.username, user.email})
    |> subject(subject)
  end

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(user, url) do
    new_info_email(user, "Confirm Email For #{user.username}")
    |> render_body("user_confirm.html", %{user: user, link: url})
    |> Mailer.deliver()
  end

  @doc """
  Deliver instructions to reset a user password.
  """
  def deliver_reset_password_instructions(user, url) do
    new_info_email(user, "Reset Password Request For #{user.username}")
    |> render_body("password_reset.html", %{user: user, link: url})
    |> Mailer.deliver()
  end

  @doc """
  Deliver instructions to update a user email.
  """
  def deliver_update_email_instructions(user, url) do
    new_info_email(user, "Update Email Request For #{user.username}")
    |> render_body("update_email.html", %{user: user, link: url})
    |> Mailer.deliver()
  end

  @doc """
  Deliver an email to confirm user wants to add a page
  """
  def deliver_user_confirm_page_instructions(user, token, pr_link, guidelines_link) do
    new_info_email(user, "New User Page For #{user.username}")
    |> render_body("authorize_user_page.html", %{
         username: user.username,
         pr_link: pr_link,
         token: token,
         guidelines_link: guidelines_link
       })
    |> Mailer.deliver()
  end
end
