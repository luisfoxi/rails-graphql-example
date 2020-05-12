class GraphqlApiSchema < GraphQL::Schema
  use GraphQL::Batch

  enable_preloading

  mutation(Types::MutationType)
  query(Types::QueryType)

  # Add built-in connections for pagination
  use GraphQL::Pagination::Connections
end
