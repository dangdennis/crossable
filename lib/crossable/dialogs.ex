defmodule Crossable.Dialogs do
  @moduledoc """
  The Dialogs context.
  """

  import Ecto.Query, warn: false
  alias Crossable.Repo
  alias Crossable.Schema.Dialogs.DiscordChannelDialogFlow
  alias Crossable.Schema.Dialogs.DialogFlow
  alias Crossable.Schema.Dialogs.DialogMessage

  @doc """
  Creates a new dialog flow.
  """
  def create_dialog_flow(attrs \\ %{}) do
    on_conflict = [
      set: [
        name: Map.get(attrs, :name),
        updated_at:
          NaiveDateTime.utc_now()
          |> NaiveDateTime.truncate(:second)
      ]
    ]

    %DialogFlow{}
    |> DialogFlow.changeset(attrs)
    |> Repo.insert(on_conflict: on_conflict, conflict_target: :name)
  end

  @doc """
  Creates a new dialog message. A dialog message exists as one of many in a dialog flow.
  """
  def create_dialog_message(attrs \\ %{}) do
    on_conflict = [
      set: [
        content: Map.get(attrs, :content),
        updated_at:
          NaiveDateTime.utc_now()
          |> NaiveDateTime.truncate(:second)
      ]
    ]

    opts =
      case Map.get(attrs, :response_match) do
        nil ->
          IO.puts("no res match")
          IO.inspect(attrs)

          [
            on_conflict: on_conflict,
            conflict_target:
              {:unsafe_fragment,
               "(dialog_flow_id, response_match, sequence_position) WHERE response_match is null"}
          ]

        _ ->
          IO.puts("res match")

          [
            on_conflict: on_conflict,
            conflict_target: [:dialog_flow_id, :sequence_position, :response_match]
          ]
      end

    %DialogMessage{}
    |> DialogMessage.changeset(attrs)
    |> Repo.insert(opts)
  end

  def print_sql(queryable) do
    IO.inspect(Ecto.Adapters.SQL.to_sql(:all, Repo, queryable))
    queryable
  end

  @doc """
  Finds the dialog message by dialog flow, sequence, and potential response match.

  # Examples
      iex> get_dialog_message(%{
        dialog_flow_id: 1,
        sequence_position: 1
      })
      {:ok, dm}

      iex> get_dialog_message(%{
        dialog_flow_id: 1,
        sequence_position: 1,
        response_match: "yes",
      })
      {:ok, dm}
  """
  @spec get_dialog_message(%{
          dialog_flow_id: integer(),
          sequence_position: integer(),
          response_match: String.t()
        }) ::
          {:error, String.t()} | {:ok, DialogMessage}
  def get_dialog_message(%{
        dialog_flow_id: dialog_flow_id,
        sequence_position: sequence_position,
        response_match: response_match
      }) do
    query =
      from dm in DialogMessage,
        where:
          dm.dialog_flow_id == ^dialog_flow_id and
            dm.sequence_position == ^sequence_position and
            dm.response_match == ^response_match

    case query |> Repo.one() do
      nil -> {:error, "failed to find dialog message"}
      dm -> {:ok, dm}
    end
  end

  @spec get_dialog_message(%{
          dialog_flow_id: integer(),
          sequence_position: integer()
        }) ::
          {:error, String.t()} | {:ok, DialogMessage}
  def get_dialog_message(%{
        dialog_flow_id: dialog_flow_id,
        sequence_position: sequence_position
      }) do
    query =
      from dm in DialogMessage,
        where:
          dm.dialog_flow_id == ^dialog_flow_id and
            dm.sequence_position == ^sequence_position and
            is_nil(dm.response_match)

    case query |> Repo.one() do
      nil -> {:error, "failed to find dialog message"}
      dm -> {:ok, dm}
    end
  end

  def get_discord_channel_dialog_flow(channel_id, flow_id) do
    query =
      from(dc_df in DiscordChannelDialogFlow,
        where: dc_df.discord_channel_id == ^channel_id and dc_df.dialog_flow_id == ^flow_id
      )

    case query |> Repo.one() do
      nil -> {:error, "failed to find discord_channel to dialog_flow"}
      dc_df -> {:ok, dc_df}
    end
  end

  def update_discord_channel_dialog_flow(%DiscordChannelDialogFlow{} = dc_df, attrs = %{}) do
    dc_df
    |> DiscordChannelDialogFlow.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Assigns a dialog flow to a channel, creates a join between discord channel and dialog flow.
  """
  @spec assign_dialog_flow_to_channel(String.t(), integer()) :: any
  def assign_dialog_flow_to_channel(channel_id, dialog_flow_id) do
    %DiscordChannelDialogFlow{}
    |> DiscordChannelDialogFlow.changeset(%{
      discord_channel_id: channel_id,
      active: true,
      dialog_flow_id: dialog_flow_id,
      sequence_position: 1
    })
    |> Repo.insert()
  end

  @doc """
  Finds the correct dialog message to send to a channel. If no response match is passed as a second argument,
  the root dialog message is returned.

  We don't increment the sequence because we expect a response from the user.
  On response, we move the user along the dialog flow.
  """
  def get_next_dialog_message_to_channel(channel_id) do
    # get the channel_dialog_flow entity
    {:ok, channel_dialog_flow} = get_discord_channel_dialog_flow(channel_id, 1)

    {:ok, dialog_msg} =
      get_dialog_message(%{
        dialog_flow_id: channel_dialog_flow.dialog_flow_id,
        sequence_position: channel_dialog_flow.sequence_position
      })

    {:ok, _updated_channel_dialog_flow} = increment_dialog_sequence(channel_dialog_flow)

    {:ok, dialog_msg}
  end

  @spec get_next_dialog_message_to_channel(String.t(), String.t() | nil) :: any
  def get_next_dialog_message_to_channel(channel_id, response_match) do
    {:ok, channel_dialog_flow} = get_discord_channel_dialog_flow(channel_id, 1)

    {:ok, dialog_msg} =
      get_dialog_message(%{
        dialog_flow_id: channel_dialog_flow.dialog_flow_id,
        sequence_position: channel_dialog_flow.sequence_position,
        response_match: response_match
      })

    {:ok, dialog_msg}
  end

  def increment_dialog_sequence(channel_dialog_flow) do
    # increment the sequence for the join entity
    update_discord_channel_dialog_flow(channel_dialog_flow, %{
      sequence_position: channel_dialog_flow.sequence_position + 1
    })
  end

  def drop_messages_for_dialog_flow(flow_id) do
    from(m in DialogMessage, where: m.dialog_flow_id == ^flow_id)
    |> Repo.delete_all()
  end
end
