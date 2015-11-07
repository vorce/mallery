defmodule Mallery do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the endpoint when the application starts
      supervisor(Mallery.Endpoint, []),
      # Start the Ecto repository
      worker(Mallery.Repo, []),
      # Here you could define other workers and supervisors as children
      # worker(Mallery.Worker, [arg1, arg2, arg3]),

      Honeydew.child_spec(:upload_pool, Mallery.Work.S3Upload, Mallery.Work.PostgresPersist, [workers: 10]),
      Honeydew.child_spec(:persist_pool, Mallery.Work.PostgresPersist, {}, [workers: 2]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mallery.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Mallery.Endpoint.config_change(changed, removed)
    :ok
  end
end
