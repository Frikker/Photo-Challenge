# frozen_string_literal: true

module Photoposts
  class Create < ActiveInteraction::Base
    string :content, default: nil
    file :picture, default: nil
    object :user
    string :remote_picture_url, default: nil
    validate(:picture || :remote_picture_url)

    def execute
      create_post
    end

    private

    def create_post
      user.photoposts.create!(content: content,
                              picture: picture,
                              remote_picture_url: remote_picture_url)
    end
  end
end