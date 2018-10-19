class AddCasheToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :replies_count, :integer, :default => 0
    add_column :posts, :views_count, :integer, :default => 0
    add_column :posts, :last_reply_time, :datetime

  # Data migration current data
    Post.find_each do |p|
      p.last_reply_time = p.replies.last.try(:created_at) # e.invoices.last 可能是 nil
      p.save(:validate => false)
    end
  end
end
