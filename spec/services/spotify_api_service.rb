require 'rails_helper'

RSpec.describe SpotifyApiService do

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