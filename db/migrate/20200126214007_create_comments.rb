class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :photopost, null: false, foreign_key: true
      t.references :parent
      t.text :content, null: false

      t.timestamps
    end

    add_index :comments, [:user_id, :parent_id, :photopost_id]
  end
end
