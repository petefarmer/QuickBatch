class SalesOrder < ApplicationRecord
  belongs_to :customer

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :sales_order_number, uniqueness: true, allow_nil: true

  before_create :set_sales_order_number

  def total
    price * quantity
  end

  private

  def set_sales_order_number
    self.sales_order_number = self.class.connection.execute("SELECT nextval('sales_order_number_seq')").first['nextval']
  end
end
