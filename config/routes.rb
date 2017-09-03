Rails.application.routes.draw do
  get 'welcome/index'

  root 'categories#index'

  get '/login' => 'sessions#login'
  post '/login' => 'sessions#create'
  # Q. What do we use delete
  # Q. Can we use get?
  delete '/logout' => 'sessions#logout'

  resources :categories, only: [:index, :show] do
    resources :articles, only: [:index, :show, :edit, :update, :destroy]
  end

  #Q. Why articles :new, :create are not nested
  resources :articles, only: [:new, :create]

  resources :users, only: [:new, :create]
end
