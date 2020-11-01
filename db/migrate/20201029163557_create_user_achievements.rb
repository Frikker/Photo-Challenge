class CreateUserAchievements < ActiveRecord::Migration[6.0]
  def change
    create_table :user_achievements do |t|
      t.references :user, null: false
      t.references :achievement, null: false

      t.timestamps
    end

    add_index :user_achievements, %i[user_id achievement_id]
  end
end
