# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiController

      def index
        
      end

      def create
        auth = request.env['omniauth.auth'].to_hash
        provider = auth['provider']

        validate Users::Create.run!(auth: auth, provider: provider)
      end

    end
  end
end