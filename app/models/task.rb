class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  def self.order_by_created_at
    self.order(created_at: :desc)
  end
end