Rails.application.routes.draw do
  resources :surveys do
    resources :questions
  end
  resources :questions, only: [:index] do
    resources :answers
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resource :users, only: [:create]
  post "/login", to: "users#login"
end
