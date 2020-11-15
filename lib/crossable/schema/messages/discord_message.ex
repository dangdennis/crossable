defmodule Crossable.Schema.Messages.DiscordMessage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "discord_messages" do
    field :recipient_id, :integer
    field :sender_id, :integer
    field :message_id, :string
    field :is_bot, :boolean
    field :content, :string
    field :deleted_at, :utc_datetime
    belongs_to :user, Crossable.Schema.Users.User

    timestamps()
  end

  @doc false
  def changeset(msg, attrs) do
    msg
    |> cast(attrs, [:message_id, :recipient_id, :sender_id, :is_bot, :content, :deleted_at])
    |> validate_required([:message_id, :recipient_id, :content, :is_bot])
  end
end
