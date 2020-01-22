Rails.application.routes.draw do
  root 'main_pages#index'
  get '/rules', to: 'main_pages#rules'
  get '/contact', to: 'main_pages#contacts'
  namespace :users do
    get 'omniauth_callbacks/facebook'
    get 'omniauth_callbacks/vkontakte'
  end
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :users
  get '/signin', to: 'users#new'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
