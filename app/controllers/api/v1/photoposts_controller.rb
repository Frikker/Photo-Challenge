# frozen_string_literal: true

module Api
  module V1
    class PhotopostsController < ApiController
      before_action :api_user, only: %i[create destroy]

      def index
        photoposts = Photopost.custom_order(params[:order_by], params[:order_type])
        render json: photoposts, current_user: api_user.id, status: :ok
      end

      def create
        validate Photoposts::Create.run(content: params[:photopost][:content],
                                        picture: params[:photopost][:picture],
                                        user: @api_user)
      end

      def destroy
        photopost = Photopost.find(params[:id])

        photopost.delete
        render json: { message: 'Deleted successfully' }, status: :ok
      end

      def show
        photopost = Photopost.find(params[:id])
        if photopost.moderating?
          raise ActiveRecord::RecordNotFound unless photopost.user == api_user

          render json: { message: "Post with id #{params[:id]} on moderation" }
        else
          render json: photopost, status: :ok, current_user: api_user.id
        end
      rescue ActiveRecord::RecordNotFound
        render json: { message: "Post with id #{params[:id]} is not found" }, status: :not_found
      end

      def search
        if params[:search].nil?
          render json: { message: 'No posts were found',
                         photoposts: Photopost.custom_order(params[:order_by], params[:order_type]) },
                 status: :bad_request
        else
          render json: { photoposts: send("#{params[:search][:model]}_search") }, current_user: api_user.id
        end
      end

      private

      def user_search
        Photopost.user_search(params[:search][:search_by], params[:search][:value])
      end

      def post_search
        Photopost.post_search(params[:search][:search_by], params[:search][:value])
      end
    end
  end
end
