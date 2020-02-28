class SessionsController < ApplicationController
  def new
    redirect_to "/auth/#{params[:format]}"
  end

  def create
    auth = request.env['omniauth.auth'].to_hash
    provider = auth['provider']
    user = Users::CreateUser.run!(auth: auth, provider: provider, user: User.new)
    if user.valid?
      reset_session
      log_in(user)
      redirect_to user, notice: 'Signed in!'
    else
      redirect_to root_url, notice: user.errors.full_messages.to_sentence
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: 'Signed out!'
  end
end