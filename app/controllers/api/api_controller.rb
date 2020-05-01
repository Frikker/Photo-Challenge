# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    before_action :check_auth, only: %i[create destroy]

    def validate(outcome)
      if outcome.valid?
        render json: { message: 'All ok' }, status: :created
      else
        render json: outcome.errors, status: :unprocessable_entity
      end
    end
  end
end
