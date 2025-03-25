class Transaction < ApplicationRecord
  belongs_to :account

  validates :date, presence: true
  validates :amount, presence: true
  validates :transaction_type, presence: true
  validates :reference_number, uniqueness: true, allow_nil: true

  TRANSACTION_TYPES = {
    debit: 'Debit',
    credit: 'Credit'
  }.freeze

  before_validation :generate_reference_number, on: :create

  private

  def generate_reference_number
    return if reference_number.present?
    self.reference_number = "TRX-#{Time.current.strftime('%Y%m%d%H%M%S')}-#{SecureRandom.hex(4)}"
  end
end
