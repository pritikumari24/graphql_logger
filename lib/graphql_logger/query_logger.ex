defmodule GraphqlLogger.QueryLogger do
  require Logger
  alias GraphqlLogger.Repo
  alias GraphqlLogger.QueryLog
  alias GraphqlLogger.CsvLogger

  def log_query(query, variables) do
    # Capture start time
    start_time = :os.system_time(:millisecond)

    # Execute the query (you may call the actual resolver or use Absinthe's built-in resolver system)
    # For this example, we are just logging query and variables
    try do
      # Perform the query resolution (mocked here as an example)
      result = {:ok, "Some Result"} # This is a placeholder for actual query execution

      # Capture execution time
      execution_time = :os.system_time(:millisecond) - start_time

      # Log query data into the database
      log_query_to_db(query, execution_time, "success", nil)

      # Log the query to the CSV file
      CsvLogger.log_to_csv(query, execution_time, "success")

      Logger.info("GraphQL Query: #{query}")
      Logger.info("Variables: #{inspect(variables)}")
      Logger.info("Execution Time: #{execution_time}ms")

      result
    rescue
      e ->
        # Capture execution time on error
        execution_time = :os.system_time(:millisecond) - start_time

        # Capture the error type, message, and stack trace
        error_details = Exception.format(:error, e, __STACKTRACE__)

        # Log the error in the database
        log_query_to_db(query, execution_time, "error", error_details)

        # Log the error to the CSV file
        CsvLogger.log_to_csv(query, execution_time, "error", error_details)

        Logger.error("GraphQL Query failed: #{query}")
        Logger.error("Error: #{inspect(e)}")

        {:error, e}
    end
  end

  defp log_query_to_db(query, execution_time, status, error_details) do
    changeset = QueryLog.changeset(%QueryLog{}, %{
      query: query,
      execution_time: execution_time,
      status: status,
      error_details: error_details
    })

    case Repo.insert(changeset) do
      {:ok, _record} -> :ok
      {:error, changeset} -> Logger.error("Failed to log query: #{inspect(changeset.errors)}")
    end
  end
end
