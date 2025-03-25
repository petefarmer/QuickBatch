class AddNumberToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :number, :string
    add_index :accounts, :number, unique: true
  end
end
