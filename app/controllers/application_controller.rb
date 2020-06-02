class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless signed_in?
      flash[:danger] = 'Please sign in'
      redirect_to root_url
    end
  end

  def signed_in?
    !current_user.nil?
  end

  def verify_authenticity_token
    token = request.headers['token']
    @api_user = User.find_by(authenticity_token: token)
  end
end
