class CommentsController < ApplicationController
  before_action :create_variables
  before_action :logged_in_user

  def create
    @comment = current_user.comments.create!(photopost_id: @photopost.id,
                                             content: comment_params[:content],
                                             parent_id: comment_params[:parent])
    if @comment.save
      flash[:success] = 'Comment added successfully'
    else
      flash[:danger] = 'Something wrong. Try again'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @photopost.comments.find(params[:id]).destroy
  end

  private

  def create_variables
    @photopost = Photopost.find(params[:photopost_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :parent)
  end
end
