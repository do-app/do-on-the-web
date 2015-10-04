Rails.application.routes.draw do
 #root 'dashboard#index'
  root 'users#index'
  resources :dashboard, only: [:index]
  resources :users #, except: [:index]
  resources :households, except: [:index] do 
  resources :chores
  end
  resources :events
  resources :sessions, only: [:new, :create, :destroy]

  mount API => '/'
end
