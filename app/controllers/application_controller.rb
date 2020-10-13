# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless signed_in?
      flash[:danger] = 'Войдите с помощью социальной сети'
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

  def respond
    respond_to do |format|
      format.js { render layout: false }
    end
  end
end
