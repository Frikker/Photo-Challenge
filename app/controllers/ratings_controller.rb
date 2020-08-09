class RatingsController < ApplicationController
  before_action :logged_in_user
  before_action :create_variables

  def create
    return if @photopost.user == current_user

    Ratings::Create.run!(user_id: current_user.id, photopost_id: @photopost.id)
    respond
  end

  def destroy
    like = Rating.find_by(user_id: current_user.id, photopost_id: @photopost.id)
    if like.nil?
      flash[:danger] = 'Something went wrong'
      redirect_back(fallback_location: request.original_url)
    else
      like.destroy
    end
    respond
  end

  private

  def create_variables
    @photopost = Photopost.find(params[:photopost_id])
  end

  def respond
    respond_to do |format|
      format.js { render layout: false }
    end
  end
end
