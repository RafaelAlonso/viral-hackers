Rails.application.routes.draw do
  require "sidekiq/web"
  devise_for :users

  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  authenticated :user do
    root 'scripts#index', as: :authenticated_root
  end

  unauthenticated :user do
    root 'pages#home', as: :unauthenticated_root
  end

  resources :scripts, only: [:new, :create, :show, :destroy] do
    member do
      put :cancel
      put :retry
    end

    resources :platform_scripts, only: [:create]
  end

  resources :platform_scripts, only: [:create, :destroy] do
      member do
        put :cancel
        put :retry
      end
    end
end
