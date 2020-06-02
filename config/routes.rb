# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      resources :photoposts do
        get '/ratings', to: 'ratings#index', as: :photoposts_ratings
        resource :ratings, only: %i[create destroy], defaults: { format: 'js' }
        resource :comments, only: %i[create destroy]
      end
      resources :users
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
    get '/rating', to: 'ratings#index', as: :rating
    post '/rating', to: 'ratings#like', as: :like, format: :js
    delete '/rating', to: 'ratings#unlike', as: :unlike, format: :js
    resource :comments, only: %i[create destroy] do
      resource :ratings, only: %i[create destroy]
    end
  end
end
