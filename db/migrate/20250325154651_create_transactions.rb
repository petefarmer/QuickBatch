class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.date :date, null: false
      t.text :description
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.references :account, null: false, foreign_key: true
      t.string :transaction_type, null: false
      t.string :reference_number

      t.timestamps
    end

    add_index :transactions, :date
    add_index :transactions, :transaction_type
    add_index :transactions, :reference_number, unique: true
  end
end
