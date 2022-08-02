Rails.application.routes.draw do
  root to: "rails_admin/main#dashboard"
  get '/health', to: "main#health"

  scope "(:locale)", locale: /en|pt-BR/ do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  Rails.application.routes.draw do
    post "/graphql", to: "graphql#execute"
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'


  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'non_profits' => "non_profits#index"
      get 'integrations' => "integrations#index"
      post 'integrations' => "integrations#create"
      get 'integrations/:id' => "integrations#show"
      put 'integrations/:id' => "integrations#update"
      post 'donations' => "donations#create"
      post 'users' => "users#create"
      post 'users/search' => "users#search"
      get 'users/impact' => "users#impact"
      post 'sources' => 'sources#create'
      resources :users, only: [] do
        get 'impacts' => 'users/impacts#index'
        get 'donations_count' => 'users/impacts#donations_count'
      end
      get 'giving_values' => "giving_values#index"
      namespace :givings do
        post 'card_fees' => 'fees#card_fees'
        get 'offers' => 'offers#index'
        get 'user_givings' => 'user_givings#index'
      end
      namespace :payments do
        post 'credit_cards'   => 'credit_cards#create'
        post 'cryptocurrency' => 'cryptocurrency#create'
        put  'cryptocurrency' => 'cryptocurrency#update_treasure_entry_status'
      end
    end
  end
end
