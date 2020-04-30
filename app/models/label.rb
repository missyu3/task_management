class Label < ApplicationRecord
  
  validates :name, presence:true

  has_many :distinctions
  has_many :tasks, through: :distinctions

end
