Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'scripts#index', as: :authenticated_root
  end

  unauthenticated :user do
    root 'pages#home', as: :unauthenticated_root
  end

  # root "articles#index"

  resources :scripts, only: [:new, :create, :show]
end
