module RatingWorker

  class RatingCreateWorker
    include Sidekiq::Worker
    sidekiq_options retry: false
    def perform(user_id, photopost_id)
      Rating.create!(user_id: user_id, photopost_id: photopost_id)
    end
  end

  class RatingDestroyWorker
    include Sidekiq::Worker
    sidekiq_options retry: false
    def perform(user_id, photopost_id)
      Rating.find_by(user_id: user_id, photopost_id: photopost_id).destroy
    end
  end
end