class FinancialReportStatus < ApplicationRecord
  belongs_to :report, polymorphic: true, optional: true

  # Define enums first
  enum :status, {
    pending: 'pending',
    processing: 'processing',
    completed: 'completed',
    failed: 'failed'
  }

  enum :report_type, {
    balance_sheet: 'balance_sheet',
    income_statement: 'income_statement',
    cash_flow: 'cash_flow',
    ebitda: 'ebitda'
  }

  enum :period_type, {
    point_in_time: 'point_in_time',
    monthly: 'monthly',
    yearly: 'yearly',
    custom: 'custom'
  }

  # Then define validations
  validates :report_type, presence: true
  validates :report_date, presence: true
  validates :period_type, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true
  validates :version, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  # Define scopes
  scope :completed, -> { where(status: :completed) }
  scope :latest_first, -> { order(version: :desc) }
  scope :for_period, ->(start_date, end_date) { where(start_date: start_date, end_date: end_date) }
  scope :by_type, ->(report_type) { where(report_type: report_type) }

  def self.create_or_increment_version(report_type, period_type, start_date, end_date)
    latest = where(
      report_type: report_type,
      period_type: period_type,
      start_date: start_date,
      end_date: end_date
    ).latest_first.first

    new_version = (latest&.version || 0) + 1

    create!(
      report_type: report_type,
      period_type: period_type,
      start_date: start_date,
      end_date: end_date,
      report_date: end_date,
      version: new_version,
      status: :pending
    )
  end

  def update_status(new_status, error_message = nil)
    assign_attributes(
      status: new_status,
      error_message: error_message,
      completed_at: new_status == :completed ? Time.current : nil
    )
    save!
  end

  def cache_key
    "financial_report/#{report_type}/#{period_type}/#{start_date&.strftime('%Y-%m-%d')}/#{end_date&.strftime('%Y-%m-%d')}/#{version}"
  end
end 