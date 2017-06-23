class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chanel
  validates :body, presence: true

  def last_message(sender_id, recipient_id)
    Chanel.between(sender_id, recipient_id).first.messages.last
  end
end
