class UserRelationship < ApplicationRecord
  belongs_to :user
  validates :friend_id, :status, presence: true
  DEFAULT_RELATIONSHIP = ['friend', 'block']
  validates :status, inclusion: { in: DEFAULT_RELATIONSHIP }

  def add_friend(user, friend_id)
    user.user_relationships.create(friend_id: friend_id, status: 'friend')
  end

  def block_friend(user, friend_id)
    user.user_relationships.find_by(friend_id: friend_id).update(status: 'block')
  end
end
