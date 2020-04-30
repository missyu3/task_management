Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks
  resources :labels, only: [:new, :create, :index, :destroy]
  resources :users
  namespace :admin do
    resources :users
  end
end

