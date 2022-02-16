Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'non_profits' => "non_profits#index"
      post 'donations' => "donations#create"
    end
  end
end
