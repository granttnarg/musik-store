require 'rails_helper'

RSpec.describe SpotifyApiService do

  describe 'auththorize successfully' do
    let(:title) { "Another Hit" }
    let!(:spotify_api_service) { described_class.new }
    let(:auth) { spotify_api_service.authorize }

    it 'returns true when a successful response comes back from Spotify' do
      expect(auth).to eq(true)
      expect(spotify_api_service.access_token).to be_a_kind_of(String)
    end
  end

  describe 'auththorize failed' do
    let(:title) { "Another Hit" }
    let!(:spotify_api_service_wrong_credentials) { described_class.new("invalid_client_id", "invalid_client_secret") }
    let(:auth) { spotify_api_service_wrong_credentials.authorize }

    it 'returns false when a successful response comes back from Spotify' do
      expect(auth).to eq(false)
        expect(spotify_api_service_wrong_credentials.access_token).to be(nil)
    end
  end




end