# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create admin user
User.create!(
  email: 'admin@example.com',
  password: 'password123',
  password_confirmation: 'password123'
) unless User.exists?(email: 'admin@example.com')

# Create standard general ledger accounts
standard_accounts = [
  # Assets (1000-1999)
  { number: '1000', name: 'Cash', account_type: 'asset', description: 'Main operating cash account' },
  { number: '1100', name: 'Accounts Receivable', account_type: 'asset', description: 'Customer receivables' },
  { number: '1200', name: 'Inventory', account_type: 'asset', description: 'Raw materials and finished goods' },
  { number: '1300', name: 'Prepaid Expenses', account_type: 'asset', description: 'Prepaid insurance, rent, etc.' },
  { number: '1400', name: 'Equipment', account_type: 'asset', description: 'Office and production equipment' },
  { number: '1500', name: 'Accumulated Depreciation', account_type: 'asset', description: 'Accumulated depreciation on equipment' },
  
  # Liabilities (2000-2999)
  { number: '2000', name: 'Accounts Payable', account_type: 'liability', description: 'Vendor payables' },
  { number: '2100', name: 'Accrued Expenses', account_type: 'liability', description: 'Accrued wages, taxes, etc.' },
  { number: '2200', name: 'Short-term Debt', account_type: 'liability', description: 'Current portion of long-term debt' },
  { number: '2300', name: 'Long-term Debt', account_type: 'liability', description: 'Long-term loans and bonds' },
  { number: '2400', name: 'Deferred Revenue', account_type: 'liability', description: 'Unearned revenue' },
  
  # Equity (3000-3999)
  { number: '3000', name: 'Common Stock', account_type: 'equity', description: 'Issued common stock' },
  { number: '3100', name: 'Retained Earnings', account_type: 'equity', description: 'Accumulated earnings' },
  { number: '3200', name: 'Dividends', account_type: 'equity', description: 'Dividends declared' },
  
  # Revenue (4000-4999)
  { number: '4000', name: 'Sales Revenue', account_type: 'revenue', description: 'Product and service sales' },
  { number: '4100', name: 'Service Revenue', account_type: 'revenue', description: 'Service-related revenue' },
  { number: '4200', name: 'Interest Income', account_type: 'revenue', description: 'Interest earned on investments' },
  
  # Expenses (5000-5999)
  { number: '5000', name: 'Cost of Goods Sold', account_type: 'expense', description: 'Direct costs of production' },
  { number: '5100', name: 'Salaries and Wages', account_type: 'expense', description: 'Employee compensation' },
  { number: '5200', name: 'Rent Expense', account_type: 'expense', description: 'Facility rental costs' },
  { number: '5300', name: 'Utilities', account_type: 'expense', description: 'Electric, water, gas, etc.' },
  { number: '5400', name: 'Insurance', account_type: 'expense', description: 'Business insurance premiums' },
  { number: '5500', name: 'Depreciation Expense', account_type: 'expense', description: 'Periodic depreciation' },
  { number: '5600', name: 'Interest Expense', account_type: 'expense', description: 'Interest on debt' },
  { number: '5700', name: 'Office Supplies', account_type: 'expense', description: 'Office materials and supplies' },
  { number: '5800', name: 'Marketing', account_type: 'expense', description: 'Advertising and promotion' },
  { number: '5900', name: 'Professional Services', account_type: 'expense', description: 'Legal, accounting, consulting' }
]

standard_accounts.each do |account|
  Account.find_or_create_by!(number: account[:number]) do |a|
    a.name = account[:name]
    a.account_type = account[:account_type]
    a.description = account[:description]
  end
end

# Create sample transactions
sample_transactions = [
  # Initial investment
  { date: Date.today - 60, description: 'Initial capital investment', amount: 100000.00, account_number: '1000', transaction_type: 'credit' },
  { date: Date.today - 60, description: 'Initial capital investment', amount: 100000.00, account_number: '3000', transaction_type: 'credit' },
  
  # Purchase of equipment
  { date: Date.today - 45, description: 'Purchase of manufacturing equipment', amount: -50000.00, account_number: '1000', transaction_type: 'debit' },
  { date: Date.today - 45, description: 'Purchase of manufacturing equipment', amount: 50000.00, account_number: '1400', transaction_type: 'credit' },
  
  # Sales transactions
  { date: Date.today - 30, description: 'Customer sale - Invoice #001', amount: 25000.00, account_number: '1100', transaction_type: 'debit' },
  { date: Date.today - 30, description: 'Customer sale - Invoice #001', amount: 25000.00, account_number: '4000', transaction_type: 'credit' },
  
  # Payment received from customer
  { date: Date.today - 15, description: 'Payment received - Invoice #001', amount: 25000.00, account_number: '1000', transaction_type: 'debit' },
  { date: Date.today - 15, description: 'Payment received - Invoice #001', amount: -25000.00, account_number: '1100', transaction_type: 'credit' },
  
  # Operating expenses
  { date: Date.today - 7, description: 'Monthly rent payment', amount: -5000.00, account_number: '1000', transaction_type: 'credit' },
  { date: Date.today - 7, description: 'Monthly rent payment', amount: 5000.00, account_number: '5200', transaction_type: 'debit' },
  
  # Payroll
  { date: Date.today - 1, description: 'Payroll for March 2025', amount: -15000.00, account_number: '1000', transaction_type: 'credit' },
  { date: Date.today - 1, description: 'Payroll for March 2025', amount: 15000.00, account_number: '5100', transaction_type: 'debit' }
]

# Create transactions
sample_transactions.each do |transaction|
  account = Account.find_by!(number: transaction[:account_number])
  Transaction.find_or_create_by!(
    date: transaction[:date],
    description: transaction[:description],
    amount: transaction[:amount],
    account: account,
    transaction_type: transaction[:transaction_type],
    reference_number: SecureRandom.uuid
  )
end
