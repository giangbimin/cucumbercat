Rails.application.routes.draw do
  get 'users/new'

  get 'index' => 'home#index'
  root 'home#index'
  resource :users
end
