class User < ApplicationRecord

  has_many :posts
  validates :name, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: /@/

  has_secure_password
end
