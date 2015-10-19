Rails.application.routes.draw do
  get 'home/index'

 #root 'dashboard#index'
  root 'sessions#new'
  resources :dashboard, only: [:index]
  resources :users #, except: [:index]
  resources :households, except: [:index] do 
  resources :chores
  end
  resources :events
  resources :sessions, only: [:new, :create, :destroy]

  mount API => '/'
end
