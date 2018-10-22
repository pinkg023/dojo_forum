class Category < ApplicationRecord
  has_many :caterelates
  has_many :posts, through: :caterelates, source: :post
end
