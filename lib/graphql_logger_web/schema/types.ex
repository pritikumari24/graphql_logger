defmodule GraphqlLoggerWeb.Schema.Types do
  use Absinthe.Schema.Notation

  # Define the Post type
  object :post do
    field :id, :id
    field :title, :string
    field :content, :string
  end
end
