# frozen_string_literal: true

module Ratings
  class Create < ActiveInteraction::Base
    integer :user_id
    integer :photopost_id

    def execute
      Rating.create!(user_id: user_id, photopost_id: photopost_id)
    end
  end
end
