class Record < ApplicationRecord
    belongs_to :artist
    has_many :likes
        AVAILABLE_GENRES = [
        "ambient",
        "classical",
        "comedy",
        "electronic",
        "hip-hop",
        "house",
        "idm",
        "indie",
        "jazz",
        "mandopop",
        "metal",
        "party",
        "piano",
        "pop",
        "punk-rock",
        "r-n-b",
        "rock",
        "rockabilly",
        "romance",
        "singer-songwriter",
        "soul",
        "soundtracks",
        "synth-pop",
        "techno",
        "trip-hop",
        "world-music"
      ]
    validates :title, uniqueness: {scope: :artist_id}, presence: true, length: {minimum: 3}
    validates :description, presence: true, length: {minimum: 10}, allow_blank: true
    validates :genre, inclusion: { in: AVAILABLE_GENRES }
end
