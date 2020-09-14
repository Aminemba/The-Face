class User < ApplicationRecord

  has_many :posts
  has_many :comments, foreign_key: 'user_id'
  has_many :comment_id, through: :comment, source: 'Post'
  has_many :likes, foreign_key: 'user_id'
  has_many :friendships
  has_many :confirmed_friends, -> { where(friendships: { friendship_status: true }) }, through: :friendships, source: :friend
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_confirmed_friends, -> { where(friendships: { friendship_status: true }) }, through: :inverse_friendships, source: :user

  validates :name, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: /@/

  def friends_and_own_posts
      Post.where(user: (confirmed_friends + inverse_confirmed_friends + [self]))
  end


  has_secure_password
end
