Rails.application.routes.draw do
  post '/rate' => 'rater#create', as: 'rate'
  root to: 'categories#index'
  resources :categories do
    resources :posts, except: ['index'] do
      resources :comments, except: ['index','new']
    end
  end
  resources :search, only: [:index]
  devise_for :users, path_prefix: 'd'
  resources :users, only: [:show, :update, :destroy]
  match '/users/:username', to: 'users#show', as: :user_profile, via: 'get'

  get '/download_file/*name', to: redirect("https://liveanimations.org/uploads/files/%{name}")
end
