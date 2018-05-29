Rails.application.routes.draw do
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users

  get 'reports/', to: 'reports#list'
  get 'reports/:project/', to: 'reports#show'
  get 'reports/:project/*path', to: 'reports#show'
  resources :reports

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
