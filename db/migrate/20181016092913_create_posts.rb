class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :image
      t.integer :user_id
      t.boolean :draft, :default => false
      t.timestamps
    end
  end
end


