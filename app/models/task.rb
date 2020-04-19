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

  def self.order_by(sort_column,sort_direction)
    sort_column ||= "created_at"
    sort_direction ||= "DESC"
    self.order(Hash[sort_column, sort_direction])
  end
end