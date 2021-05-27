require 'rails_helper'

RSpec.describe AuthenticationTokenService do
  let(:user) { FactoryBot.create(:user, username: "Mr User", password: "password") }

  describe 'call' do
    let(:token) {described_class.call(user.username)}

    it 'returns an authentication token' do
      decoded_token = JWT.decode(token,
        described_class::HMAC_SECRET,
        true,
        { algorithm: described_class::ALGORITHYM_TYPE }
      )

      expect(decoded_token).to eq([
        {'username' => user.username},
        {'alg' => 'HS256'}
      ])
    end
  end
end