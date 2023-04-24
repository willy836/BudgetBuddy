Rails.application.routes.draw do
  devise_for :users
 
  authenticated :user do
    root 'categories#index', as: :authenticated_root
  end

  unauthenticated :user do
    root to: 'splashs#index', as: :unauthenticated_root
  end
  
  resources :splashs, only: [:index]
  resources :users, only: [:index]
  resources :categories, only: [:index, :show, :new, :create, :destroy] do
    resources :products, only: [:new, :create, :destroy]
  end
end
