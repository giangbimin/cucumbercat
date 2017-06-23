class Chanel < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :user_chanels, dependent: :destroy
  has_many :users, through: :user_chanels

  scope :between, -> (sender_id, recipient_id) do
    same_rooms = UserChanel.where(user_id: sender_id).pluck(:chanel_id) & UserChanel.where(user_id: recipient_id).pluck(:chanel_id)
    where(id: same_rooms).where(chanel_type: 'private')
  end

  scope :type, -> (opition) { where(chanel_type: opition) }
  scope :search_chanel, -> (search) { where('name LIKE ?', "%#{search}%") }
  scope :search_user, -> (search) do
    users = User.where('name LIKE ?', "%#{search}%").pluck(:id)
    chanels = UserChanel.where(:user_id, users.id).pluck(:chanel_id)
    where(id: chanels)
  end
end
