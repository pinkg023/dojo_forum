class Category < ApplicationRecord
  validates_presence_of :name

  has_many :caterelates, :dependent => :restrict_with_error
  has_many :posts, through: :caterelates
end
