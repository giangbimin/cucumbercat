Rails.application.routes.draw do
  get 'index' => 'home#index'
  root 'home#index'
  resource :users
  resource :sessions, only: [:new, :create, :destroy]
  delete 'log_out' => 'sessions#destroy'
  get 'conversations/display' => 'conversations#display'

  resources :conversations do
    resources :messages
  end
end
