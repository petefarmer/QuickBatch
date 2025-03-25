class Account < ApplicationRecord
  belongs_to :parent, class_name: 'Account', optional: true
  has_many :children, class_name: 'Account', foreign_key: 'parent_id'
  has_many :transactions, dependent: :restrict_with_error

  validates :name, presence: true
  validates :account_type, presence: true
  validates :number, presence: true, uniqueness: true

  ACCOUNT_TYPES = {
    asset: 'Asset',
    liability: 'Liability',
    equity: 'Equity',
    revenue: 'Revenue',
    expense: 'Expense'
  }.freeze

  def balance
    transactions.sum(:amount)
  end

  def balance_as_of(date)
    transactions.where('date <= ?', date).sum(:amount)
  end

  def total_balance
    balance + children.sum(&:total_balance)
  end

  def total_balance_as_of(date)
    balance_as_of(date) + children.sum { |child| child.total_balance_as_of(date) }
  end

  def self.assets
    where(account_type: 'asset')
  end

  def self.liabilities
    where(account_type: 'liability')
  end

  def self.equity
    where(account_type: 'equity')
  end

  def self.revenue
    where(account_type: 'revenue')
  end

  def self.expenses
    where(account_type: 'expense')
  end

  def self.ebitda(start_date, end_date)
    revenue = revenue.sum { |account| account.total_balance_as_of(end_date) - account.total_balance_as_of(start_date) }
    expenses = expenses.sum { |account| account.total_balance_as_of(end_date) - account.total_balance_as_of(start_date) }
    revenue - expenses
  end
end
