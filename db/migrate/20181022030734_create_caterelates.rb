class CreateCaterelates < ActiveRecord::Migration[5.1]
  def change
    create_table :caterelates do |t|
      t.integer :post_id
      t.integer :category_id
      t.timestamps
    end
  end
end
