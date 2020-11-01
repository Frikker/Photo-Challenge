# frozen_string_literal: true

desc('Achievement task. Every day checking posts and grants achievement to most liked post.')

task check_likes: :environment do
  best_photopost = nil
  Photopost.where("updated_at between '#{Date.today}' and '#{Date.tomorrow}'")
           .where(aasm_state: :approved)
           .find_each do |photopost|
    best_photopost = photopost if best_photopost.nil? || photopost.rating_count > best_photopost.rating_count
  end
  if best_photopost.nil?
    puts 'No posts were uploaded.'
  else
    UserAchievement.create!(user_id: best_photopost.user.id, photopost_id: best_photopost.id,
                            achievement_id: Achievement.find_by_name('Лучший!').id)
    puts "Best photopost is chosen. It Is Photopost with ID #{best_photopost.id} by
          #{best_photopost.user.first_name + ' ' + best_photopost.user.last_name}. Achievement granted."
  end

end
