defmodule Background.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec
    children = [
      # Start the Telemetry supervisor
      BackgroundWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Background.PubSub},
      # Start the Endpoint (http/https)
      BackgroundWeb.Endpoint,
      Background.Scheduler
      # Start a worker by calling: Background.Worker.start_link(arg)
      # {Background.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Background.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BackgroundWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
