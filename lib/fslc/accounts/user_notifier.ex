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
end
