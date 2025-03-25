class FinancialReportService
  class << self
    def get_balance_sheet(date)
      get_report(:balance_sheet, date)
    end

    def get_income_statement(start_date, end_date)
      get_report(:income_statement, end_date, period_type: :monthly, start_date: start_date)
    end

    def get_cash_flow(start_date, end_date)
      get_report(:cash_flow, end_date, period_type: :monthly, start_date: start_date)
    end

    def get_ebitda(start_date, end_date)
      get_report(:ebitda, end_date, period_type: :monthly, start_date: start_date)
    end

    def regenerate_reports(start_date, end_date, report_types: nil)
      report_types ||= ['balance_sheet', 'income_statement', 'cash_flow', 'ebitda']
      
      Rails.logger.info "Manually regenerating reports for period #{start_date} to #{end_date}"
      GenerateFinancialReportsJob.perform_later(end_date, force_regenerate: true)
    end

    def report_status(report_type, start_date, end_date)
      FinancialReportStatus
        .where(report_type: report_type)
        .for_period(start_date, end_date)
        .order(version: :desc)
        .first
    end

    def latest_successful_version(report_type, period_type, start_date, end_date)
      FinancialReportStatus
        .completed
        .by_type(report_type)
        .for_period(start_date, end_date)
        .latest_first
        .first
    end

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
      # Calculate main metrics
      revenue_accounts = Account.revenue
      expense_accounts = Account.expenses.where('number LIKE ?', '5%')
      
      revenue = revenue_accounts.sum { |account| account.total_balance_as_of(end_date) - account.total_balance_as_of(start_date) }
      operating_expenses = expense_accounts.sum { |account| account.total_balance_as_of(end_date) - account.total_balance_as_of(start_date) }
      ebitda = revenue - operating_expenses
      ebitda_margin = revenue.zero? ? 0 : (ebitda / revenue) * 100

      # Generate revenue breakdown
      revenue_breakdown = revenue_accounts.map do |account|
        amount = account.total_balance_as_of(end_date) - account.total_balance_as_of(start_date)
        {
          name: account.name,
          amount: amount,
          percentage: revenue.zero? ? 0 : (amount / revenue) * 100
        }
      end.sort_by { |item| -item[:amount] }

      # Generate expenses breakdown
      expenses_breakdown = expense_accounts.map do |account|
        amount = account.total_balance_as_of(end_date) - account.total_balance_as_of(start_date)
        {
          name: account.name,
          amount: amount,
          percentage: operating_expenses.zero? ? 0 : (amount / operating_expenses) * 100
        }
      end.sort_by { |item| -item[:amount] }

      {
        revenue: revenue,
        operating_expenses: operating_expenses,
        ebitda: ebitda,
        ebitda_margin: ebitda_margin,
        revenue_breakdown: revenue_breakdown,
        expenses_breakdown: expenses_breakdown
      }
    end

    private

    def get_report(report_type, report_date, period_type: :point_in_time, start_date: nil)
      start_date ||= report_date
      
      # Try to find an existing completed report
      status = latest_successful_version(report_type, period_type, start_date, report_date)
      
      if status&.completed?
        Rails.cache.fetch(status.cache_key) do
          # If cache is empty but status exists, regenerate
          generate_report(report_type, period_type, start_date, report_date)
        end
      else
        # Generate new report if no completed status exists
        generate_report(report_type, period_type, start_date, report_date)
      end
    end

    def generate_report(report_type, period_type, start_date, end_date)
      status = FinancialReportStatus.create_or_increment_version(
        report_type,
        period_type,
        start_date,
        end_date
      )

      begin
        report_data = case report_type
        when :balance_sheet
          generate_balance_sheet(end_date)
        when :income_statement
          generate_income_statement(start_date, end_date)
        when :cash_flow
          generate_cash_flow(start_date, end_date)
        when :ebitda
          generate_ebitda(start_date, end_date)
        else
          raise "Unknown report type: #{report_type}"
        end

        # Update only the status-related attributes
        status.assign_attributes(
          status: :completed,
          completed_at: Time.current
        )
        status.save!
        
        Rails.cache.write(status.cache_key, report_data)
        report_data
      rescue StandardError => e
        # Update only the status-related attributes
        status.assign_attributes(
          status: :failed,
          error_message: e.message
        )
        status.save!
        raise e
      end
    end
  end
end 