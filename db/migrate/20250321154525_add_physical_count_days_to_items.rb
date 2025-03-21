class AddPhysicalCountDaysToItems < ActiveRecord::Migration[8.0]
  def change
    add_column :items, :physical_count_days, :integer
  end
end
