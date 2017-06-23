class User < ApplicationRecord
  has_secure_password
  validates :name, :email, presence: true
  validates :name, length: { minimum: 2, message: 'name is too short' }
  validates :name, length: { maximum: 120, message: 'name is too long' }
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, message: 'only allows letters', on: :create }

  has_many :messages, dependent: :destroy
  has_many :user_chanels, dependent: :destroy
  has_many :user_relationships, dependent: :destroy
  has_many :chanels, through: :user_chanels
end
