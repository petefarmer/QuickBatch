class EccnKey < ApplicationRecord
  has_many :items, dependent: :nullify
  
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end 