class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :token
      t.string :provider
      t.string :uid
      t.string :nickname
      t.string :urls
      t.string :image

      t.timestamps
    end

    add_index :users, :token
    add_index :users, :uid
  end
end
