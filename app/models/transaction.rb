class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :item_type, optional: true
  belongs_to :eccn_key, optional: true
  belongs_to :country, optional: true
  belongs_to :parent, class_name: 'Transaction', optional: true
  has_many :children, class_name: 'Transaction', foreign_key: 'parent_id'
  has_many :transaction_items, dependent: :destroy
  has_many :items, through: :transaction_items

  validates :date, presence: true
  validates :amount, presence: true
  validates :transaction_type, presence: true, inclusion: { in: %w[debit credit] }
  validates :reference_number, uniqueness: true, allow_nil: true

  before_validation :generate_reference_number, on: :create
  after_commit :schedule_report_generation
  after_save :invalidate_report_cache
  after_destroy :invalidate_report_cache

  private

  def generate_reference_number
    return if reference_number.present?
    self.reference_number = "TRX-#{Time.current.strftime('%Y%m%d%H%M%S')}-#{SecureRandom.hex(4)}"
  end

  def schedule_report_generation
    GenerateFinancialReportsJob.perform_later(date)
  end

  def invalidate_report_cache
    # Invalidate all report caches when a transaction changes
    Rails.cache.delete_matched("financial_report/*")
  end
end
