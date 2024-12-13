defmodule GraphqlLoggerWeb.Resolvers.PostResolver do
  def all_posts(_parent, _args, _resolution) do
    query = "all_posts"
    variables = %{}

    # Log the query
    GraphqlLogger.QueryLogger.log_query(query, variables)

    posts = [
      %{id: 1, title: "Post 1", content: "Content 1"},
      %{id: 2, title: "Post 2", content: "Content 2"}
    ]

    {:ok, posts}
  end
end
