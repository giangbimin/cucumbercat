class User < ApplicationRecord
  has_secure_password
  validates :name, :email, :gender, presence: true
  validates :name, format: { with: /\A[a-zA-Z]+\z/, message: 'only allows letters' }, length: { minimum: 2, message: 'name is too short'}
  validates :name, length: { maximum: 120, message: 'name is too long' }
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, message: 'only allows letters', on: :create }

  has_many :conversations, foreign_key: :sender_id

  after_create :create_default_conversation

  private

  def create_default_conversation
    Conversation.create(sender_id: 1, recipient_id: self.id) unless self.id == 1
  end
end
