# frozen_string_literal: true

module Comments
  class Create < ActiveInteraction::Base
    integer :photopost_id
    integer :parent_id, default: nil
    object :user
    string :content

    def execute
      create_comment
    end

    private

    def create_comment
      user.comments.create!(photopost_id: photopost_id, content: content, parent_id: parent_id)
    end
  end
end