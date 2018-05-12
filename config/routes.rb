Rails.application.routes.draw do
  # get 'reports/:project/:file', to: "reports#show"

  resources :reports

  get 'reports/:project/*path' => 'reports#link', via: :all
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
