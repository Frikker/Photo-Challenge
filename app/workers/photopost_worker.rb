module PhotopostWorker
  class DeletePhotopost
    include Sidekiq::Worker

    def perform(photopost_id)
      post = Photopost.find(photopost_id)
      return unless post.banned? || post.deleted?

      post.destroy
    end
  end
end