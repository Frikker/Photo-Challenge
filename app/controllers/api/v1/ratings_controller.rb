# frozen_string_literal: true

module Api
  module V1
    class RatingsController < ApiController
      def create
        if find_like.nil?
          validate Ratings::Create.run(photopost_id: params[:photopost_id], user_id: @api_user.id) if find_like.nil?
        else
          render json: { message: 'Post was already liked' }, status: :forbidden
        end
      end

      def destroy
        like = find_like
        if like.nil?
          render json: { message: 'This post is unliked' }, status: :no_content
        else
          like.delete
          render json: { message: 'Deleted successfully' }, status: :ok
        end
      end
    end
  end
end
