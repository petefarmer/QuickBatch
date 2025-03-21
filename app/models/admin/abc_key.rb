module Admin
  class AbcKey < ApplicationRecord
    has_many :items, foreign_key: :abc_key_id, dependent: :nullify
    
    validates :name, presence: true, uniqueness: true
    validates :description, presence: true
  end
end
