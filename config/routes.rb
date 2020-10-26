# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      resources :photoposts do
        resource :ratings, only: %i[create destroy]
        resource :comments, only: %i[create destroy]
      end
      resources :users
      get '/search', to: 'photoposts#search'
    end
  end


  root 'main_pages#index'
  get '/leaderboard', to: 'main_pages#leaderboard'
  get '/contact', to: 'main_pages#contacts'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signin', to: 'sessions#new', as: :signin
  post '/search', to: 'main_pages#search', as: :search
  delete '/signout', to: 'sessions#destroy', as: :signout
  get '/users/:id/report', to: 'users#report', as: :report

  resources :users, only: %i[create destroy show edit update]
  resources :photoposts, only: %i[create destroy show] do
    resource :ratings, only: %i[create destroy], defaults: { format: :js }
    resource :comments, only: %i[create destroy] do
      resource :comments, only: %i[create destroy], as: :reply
      resource :ratings, only: %i[create destroy]
    end
  end
end
