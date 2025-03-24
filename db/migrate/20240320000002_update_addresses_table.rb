class UpdateAddressesTable < ActiveRecord::Migration[7.0]
  def change
    # Add new columns if they don't exist
    add_column :addresses, :addressable_type, :string unless column_exists?(:addresses, :addressable_type)
    add_column :addresses, :addressable_id, :bigint unless column_exists?(:addresses, :addressable_id)
    add_column :addresses, :address_type, :integer, null: false, default: 0 unless column_exists?(:addresses, :address_type)
    add_column :addresses, :is_default, :boolean, default: false unless column_exists?(:addresses, :is_default)
    add_column :addresses, :notes, :text unless column_exists?(:addresses, :notes)

    # Add indexes if they don't exist
    unless index_exists?(:addresses, [:addressable_type, :addressable_id, :address_type], name: 'index_addresses_on_addressable_and_type')
      add_index :addresses, [:addressable_type, :addressable_id, :address_type], name: 'index_addresses_on_addressable_and_type'
    end

    unless index_exists?(:addresses, [:addressable_type, :addressable_id, :is_default], name: 'index_addresses_on_addressable_and_default')
      add_index :addresses, [:addressable_type, :addressable_id, :is_default], name: 'index_addresses_on_addressable_and_default'
    end
  end
end 