Rails.application.routes.draw do
  resources :users
  resources :orders do
    resources :meals
  end
  root 'meal_time#index'

  # authentication routes
  get '/auth/:provider/callback', to: 'sessions#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
