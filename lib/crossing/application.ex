defmodule Crossable.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Crossable.Repo,

      # Start the Telemetry supervisor
      CrossingWeb.Telemetry,

      # Start the PubSub system
      {Phoenix.PubSub, name: Crossable.PubSub},

      # Start the Endpoint (http/https)
      CrossingWeb.Endpoint,

      # Start a worker by calling: Crossable.Worker.start_link(arg)
      # {Crossable.Worker, arg}

      # Supervises Discord Gateway event consumers.
      Crossable.Consumers.Supervisor,
      {Oban, oban_config()}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Crossable.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CrossingWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  # Conditionally disable crontab, queues, or plugins here.
  defp oban_config do
    Application.get_env(:crossable, Oban)
  end
end
