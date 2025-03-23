class TrackSerialLot < ApplicationRecord
  belongs_to :auto_lot_tracking_method, optional: true
  has_many :items, dependent: :nullify
  
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
