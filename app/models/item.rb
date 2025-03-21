class Item < ApplicationRecord
  attr_accessor :abc_key_name, :commodity_key_name, :eccn_key_name

  belongs_to :item_type, optional: true
  belongs_to :item_subtype, optional: true
  belongs_to :order_method, optional: true
  belongs_to :price_group, optional: true
  belongs_to :product_key, optional: true
  belongs_to :commodity_key, optional: true
  belongs_to :abc_key, optional: true
  belongs_to :eccn_key, optional: true
  validates :item_key, presence: true, uniqueness: true
  validates :upc_key, uniqueness: true, allow_blank: true
  validates :description, presence: true
  validates :stock_unit, presence: true
  validates :physical_count_days, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :manufacturer_code, length: { maximum: 255 }
  validates :purchaseable, inclusion: { in: [true, false] }
  validates :saleable, inclusion: { in: [true, false] }

  before_save :handle_abc_key_input
  before_save :handle_commodity_key_input
  before_save :handle_eccn_key_input

  private

  def handle_abc_key_input
    # If abc_key_name is present, use that to find or create the ABC Key
    if abc_key_name.present?
      self.abc_key = AbcKey.find_or_create_by(name: abc_key_name) do |key|
        key.description = "Created from item form"
      end
    # If abc_key_name is blank but abc_key_id is present, use the selected ABC Key
    elsif abc_key_id.blank?
      # If both are blank, set abc_key to nil
      self.abc_key = nil
    end
  end

  def handle_commodity_key_input
    # If commodity_key_name is present, use that to find or create the Commodity Key
    if commodity_key_name.present?
      self.commodity_key = CommodityKey.find_or_create_by(name: commodity_key_name) do |key|
        key.description = "Created from item form"
      end
    # If commodity_key_name is blank but commodity_key_id is present, use the selected Commodity Key
    elsif commodity_key_id.blank?
      # If both are blank, set commodity_key to nil
      self.commodity_key = nil
    end
  end

  def handle_eccn_key_input
    # If eccn_key_name is present, use that to find or create the ECCN Key
    if eccn_key_name.present?
      self.eccn_key = EccnKey.find_or_create_by(name: eccn_key_name) do |key|
        key.description = "Created from item form"
      end
    # If eccn_key_name is blank but eccn_key_id is present, use the selected ECCN Key
    elsif eccn_key_id.blank?
      # If both are blank, set eccn_key to nil
      self.eccn_key = nil
    end
  end
end
