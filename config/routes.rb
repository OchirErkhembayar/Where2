Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :groups do
    resources :events, only: %i[index show new create]
    resources :usergroups, only: %i[index new create destroy]
  end
end
