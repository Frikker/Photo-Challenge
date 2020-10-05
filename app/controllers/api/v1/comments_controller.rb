# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApiController
      before_action :verify_authenticity_token, only: %i[create destroy]

      def create
        validate Comments::Create.run(photopost_id: params[:photopost_id],
                                      user: @api_user,
                                      content: params[:content],
                                      parent_id: params[:parent_id])
      end

      def destroy
        comment = Comment.find(params[:id])
        comment.delete

        render json: { message: 'Deleted successfully' }, status: :ok
      end
    end
  end
end
