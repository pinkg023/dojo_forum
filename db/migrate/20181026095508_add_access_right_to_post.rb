class AddAccessRightToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :access_right, :integer
  end
end
