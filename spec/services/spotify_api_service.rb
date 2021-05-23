require 'rails_helper'

RSpec.describe SpotifyApiService do

  AVAILABLE_GENRES = [
    "acoustic",
    "afrobeat",
    "alt-rock",
    "alternative",
    "ambient",
    "anime",
    "black-metal",
    "bluegrass",
    "blues",
    "bossanova",
    "brazil",
    "breakbeat",
    "british",
    "cantopop",
    "chicago-house",
    "children",
    "chill",
    "classical",
    "club",
    "comedy",
    "country",
    "dance",
    "dancehall",
    "death-metal",
    "deep-house",
    "detroit-techno",
    "disco",
    "disney",
    "drum-and-bass",
    "dub",
    "dubstep",
    "edm",
    "electro",
    "electronic",
    "emo",
    "folk",
    "forro",
    "french",
    "funk",
    "garage",
    "german",
    "gospel",
    "goth",
    "grindcore",
    "groove",
    "grunge",
    "guitar",
    "happy",
    "hard-rock",
    "hardcore",
    "hardstyle",
    "heavy-metal",
    "hip-hop",
    "holidays",
    "honky-tonk",
    "house",
    "idm",
    "indian",
    "indie",
    "indie-pop",
    "industrial",
    "iranian",
    "j-dance",
    "j-idol",
    "j-pop",
    "j-rock",
    "jazz",
    "k-pop",
    "kids",
    "latin",
    "latino",
    "malay",
    "mandopop",
    "metal",
    "metal-misc",
    "metalcore",
    "minimal-techno",
    "movies",
    "mpb",
    "new-age",
    "new-release",
    "opera",
    "pagode",
    "party",
    "philippines-opm",
    "piano",
    "pop",
    "pop-film",
    "post-dubstep",
    "power-pop",
    "progressive-house",
    "psych-rock",
    "punk",
    "punk-rock",
    "r-n-b",
    "rainy-day",
    "reggae",
    "reggaeton",
    "road-trip",
    "rock",
    "rock-n-roll",
    "rockabilly",
    "romance",
    "sad",
    "salsa",
    "samba",
    "sertanejo",
    "show-tunes",
    "singer-songwriter",
    "ska",
    "sleep",
    "songwriter",
    "soul",
    "soundtracks",
    "spanish",
    "study",
    "summer",
    "swedish",
    "synth-pop",
    "tango",
    "techno",
    "trance",
    "trip-hop",
    "turkish",
    "work-out",
    "world-music"
  ]

  describe 'auththorize successfully' do
    let!(:spotify_api_service) { described_class.new }
    let(:auth) { spotify_api_service.authorize }

    it 'returns true when a successful response comes back from Spotify' do
      expect(auth).to eq(true)
      expect(spotify_api_service.access_token).to be_a_kind_of(String)
    end
  end

  describe 'auththorize failed' do
    let!(:spotify_api_service_wrong_credentials) { described_class.new("invalid_client_id", "invalid_client_secret") }
    let(:auth) { spotify_api_service_wrong_credentials.authorize }

    it 'returns false when a successful response comes back from Spotify' do
      expect(auth).to eq(false)
        expect(spotify_api_service_wrong_credentials.access_token).to be(nil)
    end
  end

  describe 'search query' do
    let(:query) { "Drop it like it's hot"}
    let!(:spotify_api_service) { described_class.new }
    let!(:auth) { spotify_api_service.authorize }
    let!(:search) { spotify_api_service.search_request(query) }

    it 'returns a response of track info from search query' do
      expect(search["tracks"]).to be_a_kind_of(Hash)
      binding.pry
    end
  end

  describe 'recommendations call' do
    let(:seed_artists) {["6kBDZFXuLrZgHnvmPu9NsG"]}
    let(:seed_genres) {["electronic"]}
    let(:seed_tracks) {["2MZSXhq4XDJWu6coGoXX1V"]}
    let(:limit) {5}
    let!(:spotify_api_service) { described_class.new }
    let!(:auth) { spotify_api_service.authorize }
    let!(:recommendations) { spotify_api_service.reccomendation_request(seed_artists, seed_genres, seed_tracks, limit) }

    it 'returns a response of track info from search query' do
      expect(recommendations["tracks"].size).to eq(limit)
    end
  end
end