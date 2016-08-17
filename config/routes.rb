Rails.application.routes.draw do
  resources :sessions, only: [:create, :destroy] do
    collection do
      get 'authenticate'
    end
  end
  resources :orders do
    resources :meals
  end
  root 'meal_time#index'

  # facebook
  get '/auth/:provider/callback', to: 'sessions#create'
  # github route
  post '/auth/:provider', to: 'sessions#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
