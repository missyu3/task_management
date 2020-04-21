class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  scope :created_before, -> { order(created_at: :desc) }
  scope :title_include, -> (title) { where("title LIKE ?", "%#{title}%") if title.present?}
  scope :status_equal, -> (status) { where("status = ?", status) if status.present? }

  def self.order_by(sort_column,sort_direction)
    sort_column ||= "created_at"
    sort_direction ||= "DESC"
    self.order(Hash[sort_column,sort_direction])
  end
end