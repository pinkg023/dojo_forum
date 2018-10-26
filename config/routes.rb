Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :posts
    end
  end 

  root "posts#index"

  namespace :admin do
    resources :categories
    resources :users do
      member do
        post :enadmin
        post :unadmin
      end
    end
    root "categories#index"
  end

  resources :users do
    member do
      get :mypost
      get :mycomment
      get :mycollect
      get :mydraft
    end
  end

  resources :categories

  resources :posts do
    member do 
      post :reply
      post :collect
      post :uncollect
    end
    collection do
      get :order_last_reply
      get :order_most_reply
      get :order_most_view
    end
  end

  get 'pages/feed' => 'pages#feed'

end
