Rails.application.routes.draw do
  devise_for :users, skip: :sessions
  post "/graphql", to: "graphql#execute"
  # if Rails.env.development?
  #   mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  # end
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
