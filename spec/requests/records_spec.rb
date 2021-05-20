require 'rails_helper'

describe 'Records API', type: :request do
  context 'GET /records' do
    
    before do
      FactoryBot.create(:record, title: "This is a great song", description: "Here is some info about a great song")
    end

    it 'return all records' do
        get '/api/v1/records'

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(Record.all.size)
    end
  end

  context 'POST /records' do
    it 'creates a new record' do

      expect do
        post '/api/v1/records', params: {record: {title: "A Test Pressin", description: "A limited edition record"} }
      end.to change {Record.count}.by(1)

      expect(response).to have_http_status(:created)
    end
  end

  context 'DELETE /records' do
    let!(:record_one) { FactoryBot.create(:record, title: "This is a not so great song", description: "Here is some info about a not so great song") }

    it 'deleted a specific record entry' do
      expect do
        delete "/api/v1/records/#{record_one.id}"
      end.to change { Record.count }.by(-1)
       
      expect(response).to have_http_status(:no_content)
    end
  end

end