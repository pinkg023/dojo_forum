Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "posts#index"

  namespace :admin do
    resources :categories
    root "categories#index"
  end

  resources :categories

  resources :posts do
    member do 
      post :reply
    end
    collection do
      get :order_last_reply
      get :order_most_reply
      get :order_most_view
    end
  end

  get 'pages/feed' => 'pages#feed'

end
