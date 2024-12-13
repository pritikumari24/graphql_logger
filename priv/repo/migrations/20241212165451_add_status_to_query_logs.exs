defmodule GraphqlLogger.Repo.Migrations.AddStatusToQueryLogs do
  use Ecto.Migration

  def change do
    alter table(:query_logs) do
      add :status, :string  # Adding the `status` column
    end
  end
end
