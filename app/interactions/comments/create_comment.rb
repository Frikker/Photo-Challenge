# frozen_string_literal: true

module Comments
  class CreateComment < ActiveInteraction::Base
    integer :photopost_id
    integer :parent_id
    object :user
    string :content

    def to_model
      Comment.create
    end

    def execute
      user.comments.create!(photopost_id: photopost_id, content: content, parent_id: parent_id)
    end
  end
end