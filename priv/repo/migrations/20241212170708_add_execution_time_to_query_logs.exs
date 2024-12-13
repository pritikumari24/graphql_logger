defmodule GraphqlLogger.Repo.Migrations.AddExecutionTimeToQueryLogs do
  use Ecto.Migration

  def change do
    alter table(:query_logs) do
      add :execution_time, :integer
    end
  end
end
