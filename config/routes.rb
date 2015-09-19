Rails.application.routes.draw do
  resources :users, except: [:index] do 
    resources :chores
  end
  resources :households, except: [:index] do 
    resources :chores
  end
  resources :events
end
