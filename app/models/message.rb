class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chanel
  validates :body, presence: true

  def self.chanel_messages(user_id, chanel_id)
    block_friends = UserRelationship.where(friend_id: user_id).pluck(:id)
    Chanel.find_by(id: chanel_id).messages.where.not(user_id: block_friends)
  end

  def self.last_message(user_id, chanel_id)
    chanel_messages(user_id, chanel_id).last
  end

  def self.chanel_unread_message(user_id, chanel_id)
    Chanel.chanel_messages(user_id, chanel_id).where(read_status: false)
  end
end
