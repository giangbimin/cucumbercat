class User < ApplicationRecord
  has_secure_password
  validates :name, :email, presence: true
  validates :name, format: { with: /\A[a-zA-Z]+\z/, message: 'only allows letters' }, length: { minimum: 2, message: 'name is too short'}
  validates :name, length: { maximum: 120, message: 'name is too long' }
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, message: 'only allows letters', on: :create }
end
