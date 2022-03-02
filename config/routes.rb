Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :groups do
<<<<<<< HEAD
    resources :events, only: %i[index show new create] do
      resources :messages, only: %i[create]
=======
    resources :events, only: %i[show new create] do
>>>>>>> fa66f1b8f1e5376a9f4227f64426f6748dcf354e
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
end
