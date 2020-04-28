class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_validation { email.downcase! }
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 } 

  scope :id_asc, -> { order(id: :asc) }

  has_secure_password

  has_many :tasks, dependent: :destroy
end
