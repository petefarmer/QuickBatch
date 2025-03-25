class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.string :account_type, null: false
      t.string :account_number, null: false
      t.text :description
      t.references :parent, foreign_key: { to_table: :accounts }

      t.timestamps
    end

    add_index :accounts, :account_number, unique: true
    add_index :accounts, :account_type
  end
end
