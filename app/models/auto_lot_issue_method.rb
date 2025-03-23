class AutoLotIssueMethod < ApplicationRecord
  has_many :items

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end 