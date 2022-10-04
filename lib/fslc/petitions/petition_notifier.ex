defmodule Fslc.Petitions.PetitionNotifier do
  use Phoenix.Swoosh, view: FslcWeb.EmailView, layout: {FslcWeb.LayoutView, :email}

  alias Fslc.Mailer

  def deliver_confirmation_instructions(name, email, url) do
    new()
    |> from({"FSLC Info", "info@usufslc.com"})
    |> to({name, email})
    |> subject("Petition Confirmation for #{name}")
    |> render_body("petition_confirm.html", %{name: name, email: email, link: url})
    |> Mailer.deliver()
  end
    
end
