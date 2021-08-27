defmodule Fslc.Repo do
  use Ecto.Repo,
    otp_app: :fslc,
    adapter: Ecto.Adapters.Postgres
end
