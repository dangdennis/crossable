# Script for populating the database. You can run it as:

#     mix run priv/repo/seeds.exs

# Inside the script, you can read and write to any of your
# repositories directly:

#     Crossable.Repo.insert!(%Crossable.SomeSchema{})

# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
require Ecto.Query

Crossable.Seeds.Raids.run()
Crossable.Seeds.Dialogs.run()
