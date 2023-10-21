Rails.application.routes.draw do
  devise_for :users
  # root "articles#index"

  resources :scripts, only: [:index, :new, :create, :show]
end
