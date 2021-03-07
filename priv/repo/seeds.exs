# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Points.Repo.insert!(%Points.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Generate 100 user seeds, each with 0 points
for i <- 1..100, do: Points.Repo.insert!(%Points.User{points: 0})
