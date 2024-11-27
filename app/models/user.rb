class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  has_many :posts
  has_many :comments, through: :posts

  validates :email, uniqueness: true
  validates :name, presence: true, length: { maximum: 50 }

  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
