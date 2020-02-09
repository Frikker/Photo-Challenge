# frozen_string_literal: true

class PhotopostsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]

  def create
    @photopost = current_user.photoposts.create!(content: params[:photopost][:content],
                                                 picture: params[:photopost][:picture])
    if @photopost.save
      flash[:success] = 'Uploaded successfully'
    else
      flash[:danger] = 'Something wrong. Try again'
    end
    redirect_to user_url(current_user)
  end

  def destroy
    @photopost.destroy
    flash[:success] = 'Photopost deleted'
    redirect_to request.referrer || root_url
  end

  def show
    @photopost = Photopost.find(params[:id])
    @comments = @photopost.comments.paginate(page: params[:page])
    @comment_user = User.find(@comment.user_id) unless @comment.nil?
  end

  private
end
