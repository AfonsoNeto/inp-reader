Rails.application.routes.draw do
  root 'uploads#new'
  # resources :inp, only: [:show], constraints: {format: [:html, :inp]}
  resources :uploads, only: [:new, :create]
end
