Rails.application.routes.draw do
  root to: 'posts#index'
  resources :posts do
    resources :comments, except: ['index','new']
  end
  devise_for :users, path_prefix: 'd'
  resources :users, only: :show
  match '/users', to: 'users#index', via: 'get'
  match '/users/:id', to: 'users#show', via: 'get'
end
