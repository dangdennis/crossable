# MIX_ENV=test mix ecto.reset

ExUnit.start()
Faker.start()
Ecto.Adapters.SQL.Sandbox.mode(Crossing.Repo, :manual)
