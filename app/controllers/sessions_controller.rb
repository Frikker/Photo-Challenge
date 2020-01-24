class SessionsController < ApplicationController
  def new
    redirect_to "/auth/#{params[:format]}"
  end

  def create
    auth = request.env['omniauth.auth']
    user = User.find_by(uid: auth.uid) || User.create_new(auth)
    reset_session
    log_in(user)
    redirect_to user, notice: 'Signed in!'
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end
end
