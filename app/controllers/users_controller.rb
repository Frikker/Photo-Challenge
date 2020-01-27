class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @photopost = current_user.photoposts.build if signed_in?
    @photoposts = @user.photoposts.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(session[:user_id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
end
