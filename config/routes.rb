Rails.application.routes.draw do
  post '/rate' => 'rater#create', as: 'rate'
  root to: 'categories#index'
  resources :categories do
    resources :posts, except: ['index'] do
      resources :comments, except: ['index','new']
    end
  end
  devise_for :users, path_prefix: 'd'
  resources :users, only: :show
  match '/users/:username', to: 'users#show', as: :user_profile, via: 'get'
end
