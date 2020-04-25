Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks
  resources :users, only: [:new,:create,:show]
  namespace :admin do
    resources :users, only: [:update, :destroy, :show]
  end
end

