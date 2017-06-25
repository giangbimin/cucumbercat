class UserRelationship < ApplicationRecord
  after_create :set_default_friendship

  belongs_to :user
  validates :friend_id, presence: true

  def self.add_friend(current_user, friend_id)
    current_user.user_relationships.create(friend_id: friend_id, status: 'friend')
  end

  def self.block_friend(current_user, friend_id)
    current_user.user_relationships.find_by(friend_id: friend_id).update(status: 'block')
  end

  private

  def set_default_friendship
    self.status ||= 'friend'
  end
end
