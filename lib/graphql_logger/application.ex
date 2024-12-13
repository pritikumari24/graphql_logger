defmodule GraphqlLogger.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GraphqlLoggerWeb.Telemetry,
      GraphqlLogger.Repo,
      {DNSCluster, query: Application.get_env(:graphql_logger, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: GraphqlLogger.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: GraphqlLogger.Finch},
      # Start a worker by calling: GraphqlLogger.Worker.start_link(arg)
      # {GraphqlLogger.Worker, arg},
      # Start to serve requests, typically the last entry
      GraphqlLoggerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GraphqlLogger.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GraphqlLoggerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
