class GenerateFinancialReportsJob < ApplicationJob
  queue_as :default
  
  # Retry up to 3 times with exponential backoff
  retry_on StandardError, wait: :exponentially_longer, attempts: 3

  # Log failures to Rails logger
  rescue_from StandardError do |exception|
    Rails.logger.error "Financial report generation failed: #{exception.message}"
    Rails.logger.error exception.backtrace.join("\n")
    
    # Update status of all pending reports for this job to failed
    FinancialReportStatus.where(status: :processing).each do |status|
      status.update_status(:failed, "#{exception.class}: #{exception.message}")
    end
    
    raise exception # Re-raise to trigger retry
  end

  def perform(transaction_date, force_regenerate: false)
    Rails.logger.tagged("FinancialReports", "Transaction: #{transaction_date}") do
      Rails.logger.info "Starting financial report generation at #{Time.current}"
      
      # Set date ranges
      today = transaction_date.to_date
      start_of_month = today.beginning_of_month
      end_of_month = today.end_of_month
      start_of_year = today.beginning_of_year
      end_of_year = today.end_of_year

      # Generate and cache reports for different periods
      periods = [
        { start_date: start_of_month, end_date: end_of_month, type: 'monthly' },
        { start_date: start_of_year, end_date: end_of_year, type: 'yearly' }
      ]

      periods.each do |period|
        Rails.logger.info "Processing reports for #{period[:type]} period: #{period[:start_date]} to #{period[:end_date]}"
        
        # Balance Sheet (point-in-time report)
        generate_and_cache_report('balance_sheet', period, force_regenerate)

        # Income Statement (period report)
        generate_and_cache_report('income_statement', period, force_regenerate)

        # Cash Flow (period report)
        generate_and_cache_report('cash_flow', period, force_regenerate)

        # EBITDA (period report)
        generate_and_cache_report('ebitda', period, force_regenerate)
      end

      Rails.logger.info "Completed financial report generation at #{Time.current}"
    end
  end

  private

  def generate_and_cache_report(report_type, period, force_regenerate)
    Rails.logger.tagged(report_type.titleize) do
      Rails.logger.info "Starting generation for #{period[:type]} period"
      
      # Create or update status record
      status = FinancialReportStatus.create_or_increment_version(
        report_type,
        period[:type],
        period[:start_date],
        period[:end_date]
      )

      begin
        status.update_status(:processing)
        
        # Generate report based on type
        data = case report_type
        when 'balance_sheet'
          FinancialReportService.generate_balance_sheet(period[:end_date])
        when 'income_statement'
          FinancialReportService.generate_income_statement(period[:start_date], period[:end_date])
        when 'cash_flow'
          FinancialReportService.generate_cash_flow(period[:start_date], period[:end_date])
        when 'ebitda'
          FinancialReportService.generate_ebitda(period[:start_date], period[:end_date])
        end

        # Cache the report with version information
        Rails.cache.write(status.cache_key, {
          data: data,
          metadata: {
            generated_at: Time.current,
            version: status.version,
            period_type: period[:type],
            start_date: period[:start_date],
            end_date: period[:end_date]
          }
        }, expires_in: 24.hours)
        
        status.update_status(:completed)
        Rails.logger.info "Successfully generated and cached report (version #{status.version})"
      rescue => e
        status.update_status(:failed, "#{e.class}: #{e.message}")
        Rails.logger.error "Failed to generate report: #{e.message}"
        raise e
      end
    end
  end
end 