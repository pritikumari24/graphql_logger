defmodule GraphqlLoggerWeb.Middleware.QueryLogger do
  alias GraphqlLogger.QueryLogger

  def call(resolution, _) do
    # Extract query and variables from the resolution
    query = resolution.definition.name
    variables = resolution.arguments

    # Log the query
    QueryLogger.log_query(query, variables)

    resolution
  end
end
