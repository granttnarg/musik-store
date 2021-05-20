class Record < ApplicationRecord
    belongs_to :artist
    validates :title, uniqueness: {scope: :artist_id}, presence: true, length: {minimum: 3}
    validates :description, presence: true, length: {minimum: 10}, allow_blank: true
end
