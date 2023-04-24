Rails.application.routes.draw do
  root to: 'categories#index'
  resources :users, only: [:index]
  resources :categories, only: [:index, :show, :new, :create, :destroy] do
    resources :products, only: [:new, :create, :destroy]
  end
end
