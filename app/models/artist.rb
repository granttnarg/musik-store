class Artist < ApplicationRecord
  has_many :records
  has_many :favourites
  validates :name, presence: true
end
