# frozen_string_literal: true

class PhotopostsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]

  def create
    if params[:photopost][:content].blank?
      flash[:danger] = 'Вы забыли про эмоции:) Напишите что-нибудь'
    elsif params[:photopost][:picture].nil? && params[:photopost][:remote_picture_url].blank?
      flash[:danger] = 'А фотография где?'
    else
      @photopost = Photoposts::Create.run!(content: params[:photopost][:content],
                                           picture: params[:photopost][:picture],
                                           user: current_user,
                                           remote_picture_url: params[:photopost][:remote_picture_url])
      if @photopost.save
        current_user.restore! unless current_user.active?
        flash[:success] = 'Пост загружен успешно'
      else
        flash[:danger] = 'Что-то не так. Попробуйте еще раз'
      end
    end
    redirect_to user_url(current_user)
  end

  def destroy
    photopost = Photopost.find(params[:id])
    photopost.destroy
    flash[:success] = 'Пост удален'
    redirect_to request.referrer || root_url
  end

  def show
    @photopost = Photopost.find(params[:id])
    if @photopost.moderating?
      flash[:warning] = 'Пост проходит модерацию'
      redirect_back(fallback_location: request.original_url)
    end
    if @photopost.user != current_user && !@photopost.approved?
      flash[:danger] = 'Хитрить удумал? Нет такого поста.'
      redirect_to root_url
    end
    @comments = @photopost.comments.page(params[:page])
    @comment_user = User.find(@comment.user_id) unless @comment.nil?
  end
end