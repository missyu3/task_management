class Task < ApplicationRecord

  def self.order_by_created_at
    self.order(created_at: :desc)
  end
end
