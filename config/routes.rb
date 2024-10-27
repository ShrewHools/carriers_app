Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  resources :bids do
    collection do
      get :fetch_lowest_bid
    end
  end
  post 'sign_in' => 'sign_in#create'
  delete 'logout' => 'sign_in#destroy'
end
