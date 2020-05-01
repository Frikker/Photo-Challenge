# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      resources :photoposts
      resources :ratings
      resources :users
      resources :comments
    end
  end

  root 'main_pages#index'
  get '/rules', to: 'main_pages#rules'
  get '/contact', to: 'main_pages#contacts'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signin', to: 'sessions#new', as: :signin
  get '/signout', to: 'sessions#destroy', as: :signout

  resources :users
  resources :photoposts, only: %i[create destroy show] do
    resource :ratings, only: %i[create destroy]
    resource :comments, only: %i[create destroy]
  end
  resources :comments, only: %i[create destroy] do
    resource :ratings, only: %i[create destroy]
  end
end
