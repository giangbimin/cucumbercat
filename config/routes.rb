Rails.application.routes.draw do
  get 'index' => 'home#index'
  root 'home#index'
  resource :users
  resource :sessions, only: [:new, :create, :destroy]
  delete 'log_out' => 'sessions#destroy'

  resources :conversations do
    resources :messages
  end
  get 'conversations/display' => 'conversations#display'
  get 'conversations/load_more' => 'conversations#load_more'

  resources :friendships, only: [:create]
  get 'users/block' => 'users#block'
  get 'users/un_block' => 'users#un_block'
end
