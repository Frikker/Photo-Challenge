# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiController
      before_action :api_user, only: %i[create destroy]

      def index
        render json: User.all
      end

      def create
        auth = request.env['omniauth.auth'].to_hash
        provider = auth['provider']

        validate Users::Create.run!(auth: auth, provider: provider)
      end

      def show
        user = User.find(params[:id])
        render json: user, status: :ok
      end
    end
  end
end
