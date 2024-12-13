defmodule GraphqlLogger.QueryLog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "query_logs" do
    field :query, :string
    field :execution_time, :integer # Time in milliseconds
    field :status, :string # Success or Error

    timestamps()
  end

  def changeset(query_log, attrs) do
    query_log
    |> cast(attrs, [:query, :execution_time, :status])
    |> validate_required([:query, :execution_time, :status])
  end
end
