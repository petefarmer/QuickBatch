class AbcKey < ApplicationRecord
  self.table_name = 'abc_keys'
  has_many :items, dependent: :nullify
  
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end 