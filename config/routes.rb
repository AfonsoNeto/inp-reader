Rails.application.routes.draw do
  root 'ipns#new'
  resources :ipns, only: [:show, :new, :create]
end
