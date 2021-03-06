use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mallery, Mallery.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Set a higher stacktrace during test
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :mallery, Mallery.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "mallery_test",
  hostname: "docker",
  pool: Ecto.Adapters.SQL.Sandbox

config :mallery, :image_worker, Mallery.Work.Dummy
config :mallery, :url_worker, Mallery.Work.Dummy