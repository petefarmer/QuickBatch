class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :address_type, null: false  # e.g., 'billing', 'shipping', 'office'
      t.string :country_code, null: false  # ISO 3166-1 alpha-2 country code
      t.string :format_type, null: false   # e.g., 'us', 'uk', 'eu', 'international'
      
      # Common fields
      t.string :street_address_1
      t.string :street_address_2
      t.string :city
      t.string :state_province
      t.string :postal_code
      t.string :attention
      t.string :company_name
      
      # International fields
      t.string :district
      t.string :subdivision
      t.string :building_name
      t.string :floor_number
      t.string :room_number
      t.string :post_office_box
      
      # Contact information
      t.string :phone
      t.string :email
      
      # Metadata
      t.boolean :is_default, default: false
      t.text :notes
      
      # Polymorphic association
      t.references :addressable, polymorphic: true, null: false
      
      t.timestamps
    end
    
    add_index :addresses, [:addressable_type, :addressable_id, :address_type], name: 'index_addresses_on_addressable_and_type'
    add_index :addresses, :country_code
    add_index :addresses, :format_type
  end
end 