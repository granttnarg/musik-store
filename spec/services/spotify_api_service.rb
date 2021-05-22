require 'rails_helper'

RSpec.describe SpotifyApiService do

  describe 'call' do
    let(:title) { "Another Hit" }
    let(:token) { described_class.call(title) }

    it 'it receives and authentication token' do
      expect(token).to eq('')
    end
  end
end