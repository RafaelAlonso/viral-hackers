Rails.application.routes.draw do
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end
  
  devise_for :users
  # root "articles#index"

  resources :scripts, only: [:index, :new, :create, :show]
end
