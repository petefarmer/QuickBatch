class CreateFinancialReportStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :financial_report_statuses do |t|
      t.string :report_type, null: false
      t.string :period_type, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :status, null: false
      t.integer :version, null: false
      t.text :error_message
      t.datetime :completed_at
      t.timestamps

      t.index [:report_type, :period_type, :start_date, :end_date, :version], 
              name: 'idx_financial_report_statuses_unique_report', 
              unique: true
      t.index [:report_type, :status], name: 'idx_financial_report_statuses_type_status'
      t.index :completed_at
    end
  end
end
