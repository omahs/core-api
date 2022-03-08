Rails.application.routes.draw do
  scope "(:locale)", locale: /en|pt-BR/ do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  Rails.application.routes.draw do
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql" if Rails.env.development?
    post "/graphql", to: "graphql#execute"
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'non_profits' => "non_profits#index"
      get 'integrations/:id' => "integrations#show"
      post 'donations' => "donations#create"
      post 'users' => "users#create"
      post 'users/search' => "users#search"
    end
  end
end
