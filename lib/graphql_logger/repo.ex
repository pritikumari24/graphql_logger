defmodule GraphqlLogger.Repo do
  use Ecto.Repo,
    otp_app: :graphql_logger,
    adapter: Ecto.Adapters.Postgres
end
