class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.order_by_created_at
    self.order(created_at: :desc)
  end
  def self.order_by_limit(sort_desc = false)
    if sort_desc
      self.order(limit: :desc)
    else
      self.order(:limit)
    end
  end
end