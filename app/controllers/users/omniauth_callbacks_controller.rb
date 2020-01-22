class Users::OmniauthCallbacksController < ApplicationController
  def facebook
    @user = User.find_or_create_user_by_fb_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Facebook'
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.failure'
      redirect_to root_path
    end
  end

  def vkontakte
    @user = User.find_or_create_user_by_vk_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Vkontakte'
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.failure'
      redirect_to root_path
    end
  end
end
