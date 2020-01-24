class CreatePhotoposts < ActiveRecord::Migration[6.0]
  def change
    create_table :photoposts do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.integer :likes

      t.timestamps
    end

    add_index :photoposts, [:user_id, :created_at]
  end
end
