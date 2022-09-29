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
      post 'users/can_donate' => "users#can_donate"
      get 'users/impact' => "users#impact"
      post 'sources' => 'sources#create'
      post 'rails/active_storage/direct_uploads' => 'direct_uploads#create'
      resources :users, only: [] do
        get 'impacts' => 'users/impacts#index'
        get 'donations_count' => 'users/impacts#donations_count'
      end
      namespace :givings do
        post 'card_fees' => 'fees#card_fees'
        get 'offers' => 'offers#index'
        get 'user_givings' => 'user_givings#index'
        post 'impact_by_non_profit' => 'impacts#impact_by_non_profit'
      end
      namespace :payments do
        post 'credit_cards'   => 'credit_cards#create'
        post 'cryptocurrency' => 'cryptocurrency#create'
        put  'cryptocurrency' => 'cryptocurrency#update_treasure_entry_status'
      end
      namespace :vouchers do
        post 'donations'   => 'donations#create'
      end
      mount_devise_token_auth_for 'UserManager', at: 'auth', skip: [:omniauth_callbacks]
      namespace :manager do
        post 'auth/request', to:'authorization#google_authorization'
      end
    end
  end
end
