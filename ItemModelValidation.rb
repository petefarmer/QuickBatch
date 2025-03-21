class Item < ApplicationRecord
  # Add validations for abc_key, if needed
  validates :abc_key, presence: true, length: { maximum: 255 } # Example validation
end