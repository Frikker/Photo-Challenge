# frozen_string_literal: true

module PhotopostWorker
  class DeletePhotopost
    include Sidekiq::Worker

    sidekiq_options retry: false

    def perform(photopost_id)
      post = Photopost.find(photopost_id)
      return unless post.banned? || post.deleted?

      post.destroy
    end
  end
end