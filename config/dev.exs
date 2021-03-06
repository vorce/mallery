use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :mallery, Mallery.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin"]]

# Watch static and templates for browser reloading.
config :mallery, Mallery.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :mallery, Mallery.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "mallery_dev",
  hostname: "docker",
  pool_size: 10

config :mallery, :image_worker, Mallery.Work.S3Upload
config :mallery, :s3client, Mallery.S3Client
config :mallery, :s3bucket, "malleryimages"
config :mallery, :url_worker, Mallery.Work.RepoPersist
config :mallery, :url_prefix, "https://#{System.get_env("CLOUD_IO_TOKEN")}.cloudimg.io/s/resizeinbox/400x300/"

config :mallery, :ex_aws,
  s3: [region: "eu-west-1"]
