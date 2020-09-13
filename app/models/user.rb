class User < ApplicationRecord


  attr_accessor :password

    validates :password, presence: true, length: { minimum: 6 }
    validates :name,  presence: true, length: { maximum: 30 }
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
                      before_validation { email.downcase! }

    has_many :posts, foreign_key: 'author', dependent: :destroy
    has_many :comments, foreign_key: 'user_id'
    has_many :comment_id, through: :comment, source: 'Post'
    has_many :likes, foreign_key: 'user_id'
    has_many :friendships
    has_many :confirmed_friends, -> { where(friendships: { friendship_status: true }) }, through: :friendships, source: :friend
    has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
    has_many :inverse_confirmed_friends, -> { where(friendships: { friendship_status: true }) }, through: :inverse_friendships, source: :user

  def friends_and_own_posts
    Post.where(user: (confirmed_friends + inverse_confirmed_friends + [self]))
  end




end
