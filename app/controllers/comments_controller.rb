class CommentsController < ApplicationController
  before_action :create_variables
  before_action :logged_in_user

  def create
    @comment = Comments::CreateComment.run(user: current_user,
                                           photopost_id: @photopost.id,
                                           content: comment_params[:content],
                                           parent_id: params[:format].to_i)
    if @comment.valid?
      flash[:success] = 'Comment successfully added '
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
    @photopost = if params[:photopost_id].nil?
                   Comment.find(params[:format]).photopost
                 else
                   Photopost.find(params[:photopost_id])
                 end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
