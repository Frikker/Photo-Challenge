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
      if image.nil?
        image = user.image
      end
      user.update(first_name: first_name, last_name: last_name, image: image)
    end
  end
end