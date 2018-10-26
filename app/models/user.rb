class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  before_create :generate_authentication_token

  mount_uploader :avatar, AvatarUploader

  validates :email, :presence => true

  has_many :posts
  has_many :replies
  has_many :collects
  has_many :collect_posts, through: :collects, source: :post
  has_many :apply_friends
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friends, class_name: "Followship", foreign_key: "friend_id"

  def admin?
    self.role == "admin"
  end

  def generate_authentication_token
     self.authentication_token = Devise.friendly_token
  end

end



  

