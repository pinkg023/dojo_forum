class CreateSelfcollects < ActiveRecord::Migration[5.1]
  def change
    create_table :selfcollects do |t|

      t.timestamps
    end
  end
end
