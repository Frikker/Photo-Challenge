# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiController
      before_action :api_user, only: %i[create destroy update]

      def index
        render json: User.all
      end

      def create
        auth = request.env['omniauth.auth'].to_hash
        provider = auth['provider']

        validate Users::Create.run!(auth: auth, provider: provider)
      end

      def update
        user = User.find(params[:id])
        if @api_user == user
          validate Users::Update.run!(user: user,
                                      first_name: params[:user][:first_name],
                                      last_name: params[:user][:last_name],
                                      image: params[:user][:image])
        else
          render json: { message: 'Попытка изменить другого пользователя' }, status: :conflict
        end
      end

      def show
        user = User.find(params[:id])
        render json: user, status: :ok
      end
    end
  end
end
