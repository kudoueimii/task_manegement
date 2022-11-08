Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end

  resources :tasks
  root to: 'tasks#index'
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show] 
  
end
