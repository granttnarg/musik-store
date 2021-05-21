require 'rails_helper'

describe 'Authentication', type: :request do
  describe "POST /authenticate" do
    let(:user) { FactoryBot.create(:user, username: "Mr User", password: "qwerty") }

    it "authenticates the client" do
      post '/api/v1/authenticate', params: { username: user.username, password: "qwerty" }

      expect(response).to have_http_status(:created)
      expect(response_body).to eq( {
        'token' => 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.C2nT6QCjjTBC0O-xcbVgJDZ232FF76sKtix1DTeYLUo'
      })
    end

    it 'returns errror when username is missing' do
      post '/api/v1/authenticate', params: { password: 'password123' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq({
        'error' => 'param is missing or the value is empty: username'
      })
    end

    it 'returns error when password is missing' do
      post '/api/v1/authenticate', params: { username: 'user123' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq({
        'error' => 'param is missing or the value is empty: password'
      })
    end

    it 'returns error when password is incorrect' do
      post '/api/v1/authenticate', params: { username: user.username, password: "not this one" }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end