Rails.application.routes.draw do
  post '/', to: 'graphql#execute'
  # graphQL IDE
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"
    post "/graphql", to: "graphql#execute"
  end

  
end
