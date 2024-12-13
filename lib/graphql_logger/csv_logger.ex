defmodule GraphqlLogger.CsvLogger do
  require Logger
  alias CSV

  @csv_file "query_logs.csv"

  def log_to_csv(query_string, execution_time, status, error_details \\ nil) do
    # Create the headers if the file is empty
    if !File.exists?(@csv_file) do
      headers = ["query_string", "execution_time_ms", "status", "timestamp", "error_details"]
      write_to_csv(headers)
    end

    # Log the query data to the CSV file
    timestamp = DateTime.utc_now() |> DateTime.to_iso8601(:extended)

    # Prepare the data row
    data = [query_string, execution_time, status, timestamp, error_details]

    # Write the data to the CSV file
    write_to_csv(data)
    Logger.info("Logging query to CSV...")
    IO.inspect(data)

  end

  defp write_to_csv(data) do
    # Open the file and append the new log entry
    File.open(@csv_file, [:append, :utf8], fn file ->
      CSV.encode([data]) |> Enum.each(&IO.write(file, &1))
    end)
  end
end
