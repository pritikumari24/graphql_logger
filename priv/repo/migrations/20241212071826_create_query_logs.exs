defmodule GraphqlLogger.Repo.Migrations.CreateQueryLogs do
  use Ecto.Migration

  def change do
    create table(:query_logs) do
      add :query, :string
      add :execution_time, :integer
      add :status, :string

      timestamps()
    end
  end
end
