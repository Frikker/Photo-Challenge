Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'main_pages#index'
  get '/rules', to: 'main_pages#rules'
  get '/contact', to: 'main_pages#contacts'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signin', to: 'sessions#new', as: :signin
  get '/signout', to: 'sessions#destroy', as: :signout
  resources :users, only: %i[show edit new create index update destroy]
end
