MyTodo::Application.routes.draw do
  resources :todos do
    resources :tags, only: [:create]
    end
  root :to => 'todos#index'
end
