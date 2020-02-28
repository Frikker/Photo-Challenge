class AddRatingCountToPhotopost < ActiveRecord::Migration[6.0]
  def change
    add_column :photoposts, :rating_count, :integer, default: 0
    add_column :photoposts, :comments_count, :integer, default: 0
  end
end
