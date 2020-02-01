class RatingsController < ApplicationController
  before_action :logged_in_user
  before_action :create_variables

  def create
    RatingWorker::RatingCreateWorker.perform_async(current_user.id, @photopost.id)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    RatingWorker::RatingDestroyWorker.perform_async(current_user.id, @photopost.id)
    redirect_back(fallback_location: root_path)
  end

  private

  def create_variables
    @photopost = Photopost.find(params[:photopost_id])
  end
end
