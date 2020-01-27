class CreatePhotoposts < ActiveRecord::Migration[6.0]
  def change
    create_table :photoposts do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end

    add_index :photoposts, [:user_id, :created_at]
  end
end
