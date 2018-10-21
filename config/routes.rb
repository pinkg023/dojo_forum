Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "posts#index"

  resources :posts do
    member do 
      post :reply
    end
  end

  get 'pages/feed' => 'pages#feed'

end
