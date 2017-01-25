Rails.application.routes.draw do
  root to: 'posts#index'
  resources :posts do
    collection {post :search, to: 'posts#index'}
    resources :comments, except: ['index','new']
  end
  devise_for :users, path_prefix: 'd'
  resources :users, only: :show
  match '/users/:username', to: 'users#show', as: :user_profile, via: 'get'
end
