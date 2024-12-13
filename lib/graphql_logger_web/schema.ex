defmodule GraphqlLoggerWeb.Schema do
  use Absinthe.Schema
  import_types GraphqlLoggerWeb.Schema.Types


  # Define the Root Query Type
  query do
    field :all_posts, list_of(:post) do
      resolve &GraphqlLoggerWeb.Resolvers.PostResolver.all_posts/3
    end
  end
end
