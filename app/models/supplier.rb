class Supplier < ApplicationRecord
  # ... existing code ...

  has_many :addresses, as: :addressable, dependent: :destroy

  # ... existing code ...
end 