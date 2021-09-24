use Mix.Config

# Configure your database
config :fslc, Fslc.Repo,
  username: System.get_env("POSTGRES_USER") || "postgres",
  password: System.get_env("POSTGRES_PASS") || "postgres",
  database: System.get_env("POSTGRES_DB") || "fslc_dev",
  hostname: System.get_env("POSTGRES_HOSTNAME") || "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.

killzombies = Path.expand("../kill-hanging-watch-processes.sh", __DIR__)

config :fslc, FslcWeb.Endpoint,
  http: [port: System.get_env("HTTP_PORT") || 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false

# Watch static and templates for browser reloading.
config :fslc, FslcWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/fslc_web/(live|views)/.*(ex)$",
      ~r"lib/fslc_web/templates/.*(eex)$"
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
