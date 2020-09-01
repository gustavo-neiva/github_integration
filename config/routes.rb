Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      post '/auth/login', to: 'authentication#create'
      resources :repositories, only: :index
      resources :users, except: :index
      get  'search/repositories', to: 'search_repositories#index'
      get 'user/:username/repos', to: 'user_repositories#index'
    end
  end
end
