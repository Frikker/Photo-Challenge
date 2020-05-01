class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in_user
    unless signed_in?
      flash[:danger] = 'Please sign in'
      redirect_to root_url
    end
  end

  def signed_in?
    !current_user.nil?
  end
end
