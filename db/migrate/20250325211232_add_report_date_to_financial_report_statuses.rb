class AddReportDateToFinancialReportStatuses < ActiveRecord::Migration[7.0]
  def change
    add_column :financial_report_statuses, :report_date, :date, null: false
    add_index :financial_report_statuses, :report_date
  end
end
