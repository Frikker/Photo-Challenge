class PhotopostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @photopost = current_user.photoposts.build(photopost_params)
    if @photopost.save
      flash[:success] = 'Uploaded successfully'
      redirect_to user_url
    else
      flash[:danger] = 'Something wrong. Try again'
      redirect_to user_url
    end
  end

  def destroy

  end

  def show
    @comment = Comment.find_by(photopost: params[:id])
    @comment_user = User.find(@comment.user_id)
  end

  private

  def photopost_params
    params.require(:photopost).permit(:content)
  end
end
