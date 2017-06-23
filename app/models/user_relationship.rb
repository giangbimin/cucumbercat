class UserRelationship < ApplicationRecord
  belongs_to :user
  validates :friend_id, :status, presence: true
  DEFAULT_RELATIONSHIP = ['friend', 'block']
  validates :status, inclusion: { in: DEFAULT_RELATIONSHIP }
end
