class PhotopostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @photopost = current_user.photoposts.build(photopost_params)
    if @photopost.save
      flash[:success] = 'Uploaded successfully'
      redirect_to user_url(current_user)
    else
      flash[:danger] = 'Something wrong. Try again'
      redirect_to user_url(current_user)
    end
  end

  def destroy
    @photopost.destroy
    flash[:success] = "Photopost deleted"
    redirect_to request.referrer || root_url
  end

  def show
    @photopost = Photopost.find(params[:id])
    @comment = Comment.find_by_photopost_id(@photopost)
    @comment_user = User.find(@comment.user_id) unless @comment.nil?
  end


  private

  def photopost_params
    params.require(:photopost).permit(:content)
  end
end
