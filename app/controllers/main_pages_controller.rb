# frozen_string_literal: true

class MainPagesController < ApplicationController
  def index
    @photoposts = if params[:model].nil?
                    Photopost
                  else
                    send("#{params[:model]}_search")
                  end.custom_order(params[:order_by], params[:order_type]).page(params[:page])
    if !params[:model].nil? && @photoposts.count.zero?
      flash[:warning] = 'Найдено 0 постов.'
      redirect_to root_path
    end
  end

  def leaderboard
    @leaderboard = []
    User.all.each do |user|
      @leaderboard << { name: user.first_name + ' ' + user.last_name, photo: user.take_image,
                        likes: user.ratings.all.count, page: user.urls, id: user.id }
    end
    @leaderboard.sort_by { |post| post[:likes] }.reverse
  end

  def contacts
    render 'contacts'
  end

  def user_search
    Photopost.user_search(params[:search_by], params[:value].downcase)
  end

  def post_search
    Photopost.post_search(params[:search_by], params[:value].downcase)
  end
end
