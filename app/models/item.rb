class Item < ApplicationRecord
  belongs_to :item_type
  belongs_to :item_subtype, optional: true
  belongs_to :order_method, optional: true
  belongs_to :price_group, optional: true
  belongs_to :product_key, optional: true
  belongs_to :commodity_key, optional: true
  validates :item_key, presence: true, uniqueness: true
  validates :upc_key, presence: true, uniqueness: true
  validates :description, presence: true
  validates :item_type, presence: true
  validates :stock_unit, presence: true
end
