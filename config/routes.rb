Rails.application.routes.draw do
  resources :orders do
    resources :meals
  end
  root 'meal_time#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
