# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :create_variables
  before_action :logged_in_user

  def create
    @comment = Comments::Create.run(user: current_user,
                                    photopost_id: @photopost.id,
                                    content: comment_params[:content],
                                    parent_id: params[:comment_id].blank? ? nil : params[:comment_id].to_i)
    if @comment.valid?
      flash[:success] = 'Комментарий добавлен'
    else
      flash[:danger] = 'Что-то пошло не так. Попробуйте еще раз'
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
