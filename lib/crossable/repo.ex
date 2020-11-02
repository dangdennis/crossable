defmodule Crossable.Repo do
  use Ecto.Repo,
    otp_app: :crossable,
    adapter: Ecto.Adapters.Postgres
end
