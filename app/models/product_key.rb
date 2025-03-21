class ProductKey < ApplicationRecord
  has_many :items

  validates :name, presence: true, uniqueness: { message: "must be unique. A product key with this name already exists." }
  validates :description, presence: true
end 