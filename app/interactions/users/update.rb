# frozen_string_literal: true

module Users
  class Update < ActiveInteraction::Base
    file :image, default: nil
    string :first_name
    string :last_name
    object :user

    def execute
      update_user
    end

    private

    def update_user
      avatar_link = image.nil? ? user.avatar_link : nil
      user.update!(first_name: first_name, last_name: last_name, image: image,
                   avatar_link: avatar_link)
      user
    end
  end
end
