Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :groups do
    resources :events, only: %i[show new create] do
      resources :event_users, only: %i[create new]
    end
    resources :usergroups, only: %i[new create destroy] do
      member do
        put :accept
      end
    end
  end
  resources :events, only: %i[index]
  resources :usergroups, only: %i[index]
  resources :event_users, only: %i[index destroy] do
    member do
      put :accept
    end
  end
  resources :users, only: %i[show] do
    resources :friendships, only: %i[show new create destroy] do
      member do
        put :accept
      end
    end
  end
  resources :friendships, only: %i[index]
end
