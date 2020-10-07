# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy report]

  def show
    redirect_to root_path unless current_user
    @user = User.find(params[:id])
    if @user == current_user
      @photopost = current_user.photoposts.build if signed_in?
      @photoposts = @user.photoposts.order(aasm_state: :asc).page(params[:page])
      @banned_photoposts = @photoposts.where(aasm_state: 'banned')
      flash[:danger] = "У тебя #{@banned_photoposts.count} постов на удаление. Делай что-нибудь" if @banned_photoposts.any?
    else
      @photoposts = @user.photoposts.where.not(aasm_state: 'banned').order(id: :asc).page(params[:page])
    end
    @likes = 0
    @photoposts.each { |photopost| @likes += photopost.rating.count }
  end

  def edit
    @user = User.find(params[:id])
  end

  def search
    user = User.find_by(params[:search_by] => params[:search])
    if user.nil?
      flash[:danger] = 'Нет такого пользователя'
      redirect_to root_path
    end
    @photoposts = user.photoposts
    render 'main_pages/index'
  end

  def update
    @user = User.find(session[:user_id])
    if Users::Update.run!(user: @user,
                          first_name: params[:user][:first_name],
                          last_name: params[:user][:last_name],
                          image: params[:user][:image])
      flash[:success] = 'Твой профиль изменен'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def report
    report = Users::Report.run!(reason_id: params[:reason_id], from_id: current_user.id,
                                reason_class: params[:report_reason])
    flash[:danger] = 'Зачем ты репортишь себя?' if report.nil?
    redirect_to request.referrer || root_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
