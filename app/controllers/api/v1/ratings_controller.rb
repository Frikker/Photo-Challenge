# frozen_string_literal: true

module Api
  module V1
    class RatingsController < ApiController
      def create
        validate Ratings::Create.run(photopost_id: params[:photopost_id], user_id: @api_user.id) if find_like.nil?
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

      private

      def find_like
        Rating.find_by(photopost_id: params[:photopost_id], user_id: @api_user.id)
      end
    end
  end
end
