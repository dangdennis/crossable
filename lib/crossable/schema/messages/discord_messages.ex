defmodule Crossable.Messages.DiscordMessage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "discord_messages" do
    field :recipient_id, :integer
    field :sender_id, :integer
    field :is_bot, :boolean
    field :message, :string
    field :deleted_at, :utc_datetime
    belongs_to :user, Crossable.Users.User

    timestamps()
  end

  @doc false
  def changeset(habit, attrs) do
    habit
    |> cast(attrs, [:recipient_id, :sender_id, :is_bot, :message, :deleted_at])
    |> validate_required([:recipient_id, :message, :is_bot])
  end
end
