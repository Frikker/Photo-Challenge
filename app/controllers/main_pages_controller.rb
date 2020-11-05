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
    Photopost.all.order(user_id: :asc).each do |photopost|
      post = @leaderboard.select { |local_post| local_post[:page] == photopost.user.urls }
      if post.empty?
        @leaderboard << { id: photopost.user.id,
                          photo: photopost.user.take_image,
                          name: photopost.user.first_name + ' ' + photopost.user.last_name,
                          page: photopost.user.urls,
                          likes: photopost.rating_count }
      else
        post[0][:likes] += photopost.rating_count
      end
    end
    @leaderboard = @leaderboard.sort_by { |post| -post[:likes] }
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
