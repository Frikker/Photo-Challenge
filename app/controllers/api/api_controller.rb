# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    protect_from_forgery with: :null_session
    def api_user
      @api_user = User.find_by(authenticity_token: request.headers[:authenticity_token])
      render json: { error: 'Unauthorized user' }, status: :unauthorized unless @api_user
    end

    def validate(outcome)
      if outcome.valid?
        render json: { message: 'Success' }, status: :created
      else
        render json: outcome.errors, status: :unprocessable_entity
      end
    end
  end
end
