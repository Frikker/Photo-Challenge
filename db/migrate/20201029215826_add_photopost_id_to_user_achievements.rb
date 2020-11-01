class AddPhotopostIdToUserAchievements < ActiveRecord::Migration[6.0]
  def change
    add_column :user_achievements, :photopost_id, :integer, null: true, default: nil

    add_index :user_achievements, :photopost_id
  end
end
