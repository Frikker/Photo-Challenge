class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.integer :likes
      t.integer :dislikes
      t.references :photopost
      t.references :comment
      t.timestamps
    end

    add_index :ratings, [:photopost_id, :comment_id]
  end
end
