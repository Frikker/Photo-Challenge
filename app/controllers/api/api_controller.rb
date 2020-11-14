# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    protect_from_forgery with: :null_session

    def api_user
      @api_user = User.find_by(authenticity_token: request.env['HTTP_AUTHENTICITY_TOKEN'])
      render json: { error: 'Unauthorized user' }, status: :unauthorized unless @api_user
      @api_user
    end

    def validate(outcome)
      if outcome.valid?
        render json: { message: 'Success', code_message: 1 }, status: :created
      else
        render json: outcome.errors, status: :unprocessable_entity
      end
    end

    def find_like
      Rating.find_by(photopost_id: params[:photopost_id], user_id: @api_user.id)
    end

    def docs
      render 'api/docs'
    end
  end
end
