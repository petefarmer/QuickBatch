class RenameAutoLotTrackingMethodToAutoLotIssueMethod < ActiveRecord::Migration[7.1]
  def change
    rename_table :auto_lot_tracking_methods, :auto_lot_issue_methods
    rename_column :items, :auto_lot_tracking_method_id, :auto_lot_issue_method_id
  end
end 