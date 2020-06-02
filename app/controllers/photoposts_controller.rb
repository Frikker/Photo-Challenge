# frozen_string_literal: true

class PhotopostsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]

  def create
    if params[:photopost][:picture].nil?
      flash[:danger] = 'Photo is missing'
    else
      @photopost = Photoposts::Create.run!(content: params[:photopost][:content],
                                           picture: params[:photopost][:picture],
                                           user: current_user)
      if @photopost.save
        flash[:success] = 'successfully Uploaded '
      else
        flash[:danger] = 'Something wrong. Try again'
      end
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
    if @photopost.user != current_user && @photopost.approved?
      flash[:danger] = 'There is no post with that id'
      redirect_to root_url
    end
    @comments = @photopost.comments.page(params[:page])
    @comment_user = User.find(@comment.user_id) unless @comment.nil?
  end

end
