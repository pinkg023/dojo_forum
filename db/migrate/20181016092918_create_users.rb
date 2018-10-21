class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :avatar
      t.integer :replies_count, :default => 0
      t.timestamps
    end
  end
end
