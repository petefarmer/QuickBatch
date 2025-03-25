class FinancialReportService
  class << self
    def generate_balance_sheet(date)
      {
        assets: Account.assets.map { |account| { name: account.name, amount: account.total_balance_as_of(date) } },
        liabilities: Account.liabilities.map { |account| { name: account.name, amount: account.total_balance_as_of(date) } },
        equity: Account.equity.map { |account| { name: account.name, amount: account.total_balance_as_of(date) } },
        total_assets: Account.assets.sum { |account| account.total_balance_as_of(date) },
        total_liabilities: Account.liabilities.sum { |account| account.total_balance_as_of(date) },
        total_equity: Account.equity.sum { |account| account.total_balance_as_of(date) }
      }
    end

    def generate_income_statement(start_date, end_date)
      {
        revenue: Account.revenue.map { |account| { name: account.name, amount: account.total_balance_as_of(end_date) - account.total_balance_as_of(start_date) } },
        expenses: Account.expenses.map { |account| { name: account.name, amount: account.total_balance_as_of(end_date) - account.total_balance_as_of(start_date) } },
        total_revenue: Account.revenue.sum { |account| account.total_balance_as_of(end_date) - account.total_balance_as_of(start_date) },
        total_expenses: Account.expenses.sum { |account| account.total_balance_as_of(end_date) - account.total_balance_as_of(start_date) },
        net_income: Account.revenue.sum { |account| account.total_balance_as_of(end_date) - account.total_balance_as_of(start_date) } -
                   Account.expenses.sum { |account| account.total_balance_as_of(end_date) - account.total_balance_as_of(start_date) }
      }
    end

    def generate_cash_flow(start_date, end_date)
      cash_account = Account.find_by(number: '1000') # Cash account
      return nil unless cash_account

      operating_activities = cash_account.transactions.where(date: start_date..end_date, transaction_type: 'operating')
      investing_activities = cash_account.transactions.where(date: start_date..end_date, transaction_type: 'investing')
      financing_activities = cash_account.transactions.where(date: start_date..end_date, transaction_type: 'financing')

      {
        operating_activities: operating_activities.map { |t| { description: t.description, amount: t.amount } },
        investing_activities: investing_activities.map { |t| { description: t.description, amount: t.amount } },
        financing_activities: financing_activities.map { |t| { description: t.description, amount: t.amount } },
        net_operating_cash: operating_activities.sum(:amount),
        net_investing_cash: investing_activities.sum(:amount),
        net_financing_cash: financing_activities.sum(:amount),
        net_cash_change: operating_activities.sum(:amount) + investing_activities.sum(:amount) + financing_activities.sum(:amount)
      }
    end

    def generate_ebitda(start_date, end_date)
      revenue = Account.revenue.sum { |account| account.total_balance_as_of(end_date) - account.total_balance_as_of(start_date) }
      operating_expenses = Account.expenses.where('number LIKE ?', '5%').sum { |account| account.total_balance_as_of(end_date) - account.total_balance_as_of(start_date) }
      ebitda = revenue - operating_expenses
      ebitda_margin = revenue.zero? ? 0 : (ebitda / revenue) * 100

      {
        revenue: Account.revenue.map { |account| { name: account.name, amount: account.total_balance_as_of(end_date) - account.total_balance_as_of(start_date) } },
        operating_expenses: Account.expenses.where('number LIKE ?', '5%').map { |account| { name: account.name, amount: account.total_balance_as_of(end_date) - account.total_balance_as_of(start_date) } },
        total_revenue: revenue,
        total_operating_expenses: operating_expenses,
        ebitda: ebitda,
        ebitda_margin: ebitda_margin
      }
    end
  end
end 