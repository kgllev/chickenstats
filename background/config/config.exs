# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :background, BackgroundWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FEVvKzJ1A9oB6UDdDwYZlc/NIOcsOZSxqw5ZNUDuf3RLfn9T2wFD0U6XfZ4dv/uS",
  render_errors: [view: BackgroundWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Background.PubSub,
  live_view: [signing_salt: "VQ3D0z5V"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :background, Background.Scheduler,
       jobs: [
         {"* * * * *", {Background.Jobs, :handle_request, [:chicken_derby, 5]}}
       ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
