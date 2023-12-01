Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql#execute"
  end
  post "/graphql", to: "graphql#execute"
  resources :surveys do
    resources :questions, only: [ :index, :create, :update, :destroy ]
    resources :answers, only: [ :index, :create ]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resource :users, only: [:create]
  post "/login", to: "users#login"
  get "/surveys_all", to: "surveys#all_surveys"
  get "/answers", to: "answers#all_answers"
end
