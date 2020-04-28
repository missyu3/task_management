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

  def self.update_params(params)
    params.delete(:name) if params[:name].blank?
    params.delete(:email) if params[:email].blank?
    params.delete(:admin) if params[:admin].blank?
    params.delete(:password) if params[:password].blank?
    params.delete(:password_confirmation) if params[:password_confirmation].blank?
    params
  end
end
