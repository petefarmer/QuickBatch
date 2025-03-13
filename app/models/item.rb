class Item < ApplicationRecord
  belongs_to :item_type, optional: true
  belongs_to :item_subtype, optional: true
  validates :item_key, presence: true
  validates :upc_key, presence: true
  validates :description, presence: true
  validates :item_type, presence: true
  validates :item_subtype, presence: true
end
