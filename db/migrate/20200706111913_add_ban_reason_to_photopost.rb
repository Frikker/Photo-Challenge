class AddBanReasonToPhotopost < ActiveRecord::Migration[6.0]
  def change
    add_column :photoposts, :ban_reason, :string
  end
end
