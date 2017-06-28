class User < ApplicationRecord
  has_secure_password
  validates :name, :email, :gender, presence: true
  validates :name, length: { minimum: 2, message: 'name is too short' }
  validates :name, length: { maximum: 120, message: 'name is too long' }
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, message: 'only allows letters', on: :create }

  has_many :conversations, foreign_key: :sender_id
  has_many :friendships, -> { where(blocked: false) }
  has_many :friends, through: :friendships, class_name: 'User'

  after_create :create_default_conversation

  def blockers
    block_ids = Friendship.where(friend: self, blocked: true).pluck(:friend_id)
    User.where(id: block_ids)
  end

  def blocked_by(user)
    # user blocked self
    Friendship.find_by(user: self, friend: user).blocked == true
  end

  def find_conversation_by(user)
    Conversation.between(self.id, user.id).first
  end

  private

  def create_default_conversation
    Conversation.create(sender_id: self.id, recipient_id: self.id) unless self.id == 1
  end
end
