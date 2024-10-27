Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  resources :bids
  post 'sign_in' => 'sign_in#create'
  delete 'logout' => 'sign_in#destroy'
end
