class Conversation < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, scope: :recipient_id

  # before_create :set_type, :create_unread_messages

  scope :involving, -> (user) do
    where('conversations.sender_id =? OR conversations.recipient_id =?', user.id, user.id)
  end

  scope :between, -> (sender_id, recipient_id) do
    where('(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)', sender_id, recipient_id, recipient_id, sender_id)
  end

  def self.order_by_messages
    c_ids = Message.order(created_at: :DESC).pluck(:conversation_id).uniq
    where(id: c_ids)
  end

  def last_message
    messages.last
  end

  def unread_messages(recipient)
    messages.where.not(user: recipient).where(unread: true)
  end

  def count_unread_messages(recipient)
    unread_messages(recipient).count
  end

  def self.conversation_of(user_id, friend_id)
    Conversation.between(user_id, friend_id).first
  end

  def members
    u_ids = Message.where(conversation: self).pluck(:user_id)
    User.where(id: [u_ids])
  end

  def recipients(sender)
    # for chat room
    # members.reject { |member| member.id == sender.id }
    members.reject { |member| member.id == sender.id }.first
  end
end
