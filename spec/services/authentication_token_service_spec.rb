require 'rails_helper'

RSpec.describe AuthenticationTokenService do
  describe 'call' do
    let(:token) {described_class.call}

    it 'returns an authentication token' do
      decoded_token = JWT.decode(token,
        HMAC_SECRET,
        true,
        { algorithm: ALOGRIYTHM_TYPE }
      )

      expect(decoded_token).to eq([
        {'test' => 'testing'},
        {'alg' => 'HS256'}
      ])
    end
  end
end