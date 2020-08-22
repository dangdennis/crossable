defmodule Crossing.Repo do
  use Ecto.Repo,
    otp_app: :crossing,
    adapter: Ecto.Adapters.Postgres
end
