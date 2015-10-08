Rails.application.routes.draw do
  root 'dashboard#index'
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

  mount API => '/'
end
