Rails.application.routes.draw do
  # post "/graphql", to: "graphql#execute"
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  Rails.application.routes.draw do
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql" if Rails.env.development?
    post "/graphql", to: "graphql#execute"
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'non_profits' => "non_profits#index"
      get 'integrations/:id' => "integrations#show"
      post 'donations' => "donations#create"
    end
  end
end
