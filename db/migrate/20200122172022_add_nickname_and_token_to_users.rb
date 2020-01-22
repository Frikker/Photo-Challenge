class AddNicknameAndTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.string :nickname, null: false, default: ""
      t.string :token,    null: false

    end
  end
end
