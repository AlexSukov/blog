Rails.application.routes.draw do
  root to: 'posts#index'
  resources :posts do
    resources :comments, except: ['index','new']
  end
  devise_for :users
  match '/users',   to: 'users#index',   via: 'get'
end
