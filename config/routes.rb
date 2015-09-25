Rails.application.routes.draw do
  resources :users, except: [:index]
  resources :households, except: [:index] do 
    resources :chores
  end
  resources :events
  resources :sessions, only: [:new, :create, :destroy]
end
