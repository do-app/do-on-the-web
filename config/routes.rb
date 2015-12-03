Rails.application.routes.draw do
  
  get "/home/index", as: "home"
      
  # root 'dashboard#index'
  root 'sessions#new'
  resources :dashboard, only: [:index]
  resources :users , except: [:index]
  resources :households do 
    resources :chores, except: [:index, :show] do 
      #put 'assign', on: :member
	  patch 'verify'
	  patch 'unverify'
	  patch 'request_verification'
    end
	patch 'assign_chores'
    put 'join', on: :member
    put 'leave', on: :member
    get 'search', on: :collection
    get 'results', on: :collection
  end

  resources :events
  resources :sessions, only: [:new, :create, :destroy]
  resources :messages
end
