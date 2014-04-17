MyTodo::Application.routes.draw do
  resources :todos do
    resources :tags, only: [:create]
    end
  root :to => 'todos#index'

  get 'front_page', to: 'pages#front'

  resources :sessions, only: [:create, :destroy]
  get 'sign_out', to: 'sessions#destroy'
end
