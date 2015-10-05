Rails.application.routes.draw do
  get 'home/index'

  root 'dashboard#index'
  # root 'sessions#new'
  resources :dashboard, only: [:index]
  resources :users, except: [:index]
  resources :households do 
    resources :chores
    put 'join', on: :member
    put 'leave', on: :member
    get 'search', on: :collection
    get 'results', on: :collection
  end

  resources :events
  resources :sessions, only: [:new, :create, :destroy]
end
