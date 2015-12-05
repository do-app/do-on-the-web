Rails.application.routes.draw do
  
  get "/home/index", as: "home"
      
  root 'sessions#new'
  resources :users , except: [:index]
  resources :households do 
    resources :chores, except: [:index, :show] do 
      put 'assign', on: :member
      put 'complete', on: :member
    end
    put 'join', on: :member
    put 'leave', on: :member
    get 'search', on: :collection
    get 'results', on: :collection
  end

  resources :rewards, except: [:index, :show] do 
    put 'claim', on: :member
  end
  resources :events
  resources :sessions, only: [:new, :create, :destroy]
  resources :messages
end
