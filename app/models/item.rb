class Item < ApplicationRecord
  attr_accessor :abc_key_name, :commodity_key_name, :eccn_key_name, :track_serial_lot_name

  belongs_to :item_type, optional: true
  belongs_to :item_subtype, optional: true
  belongs_to :order_method, optional: true
  belongs_to :price_group, optional: true
  belongs_to :product_key, optional: true
  belongs_to :commodity_key, optional: true
  belongs_to :abc_key, optional: true
  belongs_to :eccn_key, optional: true
  belongs_to :track_serial_lot, optional: true
  belongs_to :auto_lot_tracking_method, optional: true

  validates :item_key, presence: true, uniqueness: true
  validates :upc_key, uniqueness: true, allow_blank: true
  validates :description, presence: true
  validates :stock_unit, presence: true
  validates :production_unit, inclusion: { in: ['kg', 'lb', 'ea'] }, allow_nil: true
  validates :purchase_unit, inclusion: { in: ['kg', 'lb', 'ea'] }, allow_nil: true
  validates :sales_unit, inclusion: { in: ['kg', 'lb', 'ea'] }, allow_nil: true
  validates :height, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :width, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :length, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :weight, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :physical_count_days, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :manufacturer_code, length: { maximum: 255 }
  validates :purchaseable, inclusion: { in: [true, false] }
  validates :saleable, inclusion: { in: [true, false] }

  before_save :handle_abc_key_input
  before_save :handle_commodity_key_input
  before_save :handle_eccn_key_input
  before_save :handle_track_serial_lot_input

  private

  def handle_abc_key_input
    if abc_key_name.present?
      self.abc_key = AbcKey.find_or_create_by(name: abc_key_name) do |key|
        key.description = "Created from item form"
      end
    elsif abc_key_id.blank?
      self.abc_key = nil
    end
  end

  def handle_commodity_key_input
    if commodity_key_name.present?
      self.commodity_key = CommodityKey.find_or_create_by(name: commodity_key_name) do |key|
        key.description = "Created from item form"
      end
    elsif commodity_key_id.blank?
      self.commodity_key = nil
    end
  end

  def handle_eccn_key_input
    if eccn_key_name.present?
      self.eccn_key = EccnKey.find_or_create_by(name: eccn_key_name) do |key|
        key.description = "Created from item form"
      end
    elsif eccn_key_id.blank?
      self.eccn_key = nil
    end
  end

  def handle_track_serial_lot_input
    if track_serial_lot_name.present?
      self.track_serial_lot = TrackSerialLot.find_or_create_by(name: track_serial_lot_name) do |lot|
        lot.description = "Auto-generated from item creation"
      end
    elsif track_serial_lot_id.blank?
      self.track_serial_lot = nil
    end
  end
end
