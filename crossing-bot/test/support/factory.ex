# defmodule Crossing.Factory do
#   alias Crossing.Repo

#   # Factories

#   def build(:post) do
#     %Crossing.Post{title: "hello world"}
#   end

#   def build(:comment) do
#     %Crossing.Comment{body: "good post"}
#   end

#   def build(:post_with_comments) do
#     %Crossing.Post{
#       title: "hello with comments",
#       comments: [
#         build(:comment, body: "first"),
#         build(:comment, body: "second")
#       ]
#     }
#   end

#   def build(:user) do
#     %Crossing.User{
#       email: "hello#{System.unique_integer()}",
#       username: "hello#{System.unique_integer()}"
#     }
#   end

#   # Convenience API

#   def build(factory_name, attributes) do
#     factory_name |> build() |> struct!(attributes)
#   end

#   def insert!(factory_name, attributes \\ []) do
#     factory_name |> build(attributes) |> Repo.insert!()
#   end
# end
