class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.references :photopost, null: true
      t.references :user
      t.timestamps
    end

    add_index :ratings, [:photopost_id,  :user_id]
  end
end
