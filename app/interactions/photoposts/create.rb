# frozen_string_literal: true

module Photoposts
  class Create < ActiveInteraction::Base
    string :content, default: nil
    file :picture
    object :user

    def execute
      create_post
    end

    private

    def create_post
      user.photoposts.create!(content: content,
                              picture: picture)
    end
  end
end