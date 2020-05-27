Rails.application.routes.draw do
  devise_for :users
 root 'posts#index'
 get 'users/:id' => 'posts#user_saves', :as => :user_saves
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :saves
  end
resources :tags, only: [:show]
resources :users do
  member do
    get :posts
  end
end
end
