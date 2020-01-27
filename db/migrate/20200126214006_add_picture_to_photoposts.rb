class AddPictureToPhotoposts < ActiveRecord::Migration[6.0]
  def change
    add_column :photoposts, :picture, :string
  end
end
