defmodule GraphqlLogger.Repo.Migrations.AddErrorDetailsToQueryLogs do
  use Ecto.Migration

  def change do
    alter table(:query_logs) do
      add :error_details, :text
    end
  end
end
