class Category < ApplicationRecord
  has_many :caterelates
  has_many :cate_posts, through: :caterelates, source: :post
end
