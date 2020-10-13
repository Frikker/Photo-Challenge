# frozen_string_literal: true

class MainPagesController < ApplicationController
  def index
    @photoposts = Photopost.custom_order(params[:order_by], params[:order_type]).page(params[:page])
  end

  def leaderboard
    @photoposts = Photopost.all
    @leaderboard = []
    @photoposts.each do |photopost|
      post = @leaderboard.select { |post| post[:page] == photopost.user.urls }
      if post.empty?
        @leaderboard << { id: photopost.user.id,
                          photo: photopost.user.take_image,
                          first_name: photopost.user.first_name,
                          last_name: photopost.user.last_name,
                          page: photopost.user.urls,
                          likes: photopost.rating_count }
      else
        post[0][:likes] += photopost.rating_count
      end
    end
    @leaderboard.sort_by { |post| post[:likes] }.reverse
  end

  def search
    if params[:search_by] == 'content'
      @photoposts = Photopost.where('lower(content) like ?', "%#{params[:search].downcase}%").all.page(params[:page])
    elsif params[:search_by] == 'name'
      user = User.find_by_first_name(params[:search])
      if user.nil?
        flash[:danger] = 'Нет такого пользователя'
        redirect_to root_path
      end
      @photoposts = user.photoposts.page
    end
    respond
  end

  def contacts
    render 'contacts'
  end
end
