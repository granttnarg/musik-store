require 'rails_helper'

describe 'Records API', type: :request do
  let!(:artist) { FactoryBot.create(:artist, name: "George Michael", bio: "Some info about George Michael") }
  let!(:record) { FactoryBot.create(:record, artist: artist, title: "This is a great song", description: "Here is some info about a great song") }
  let!(:record_one) { FactoryBot.create(:record, artist: artist, title: "Another Hit", description: "Update info later") }
  
  context 'GET /records' do
    it 'return all records' do
        get '/api/v1/records'

        expect(response).to have_http_status(:success)
        expect(response_body.size).to eq(Record.all.size)
        expect(response_body).to eq(
          [{
            'id'=> 1,
            'title' => 'This is a great song',
            'description' => 'Here is some info about a great song',
            'artist' => {
              'name' => 'George Michael',
              'bio' => 'Some info about George Michael',
              'artist_id' => 1
            }    
          },
          {
            'id'=> 2,
            'title' => 'Another Hit',
            'description' => 'Update info later',
            'artist' => {
              'name' => 'George Michael',
              'bio' => 'Some info about George Michael',
              'artist_id' => 1
            }    
          }
        ])
    end

    it 'it returns a subset of records using pagination limit via params' do
      get '/api/v1/records', params: { limit: 1 } 

      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(1)
      expect(response_body).to eq( [
        {
          'id'=> 1,
          'title' => 'This is a great song',
          'description' => 'Here is some info about a great song',
          'artist' => {
            'name' => 'George Michael',
            'bio' => 'Some info about George Michael',
            'artist_id' => 1
          }    
        }
      ])
    end

    it 'returns a subset of records based on limit and offset' do
      get '/api/v1/records', params: { limit: 1, offset: 1 }
      
      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(1)
      expect(response_body).to eq([
        {
            'id'=> 2,
            'title' => 'Another Hit',
            'description' => 'Update info later',
            'artist' => {
              'name' => 'George Michael',
              'bio' => 'Some info about George Michael',
              'artist_id' => 1
            }    
          }
      ])
    end
    
    it 'returns records with a max limit fo 100' do
      expect(Record).to receive(:limit).with(100).and_call_original 
      
      get '/api/v1/records', params: { limit: 999, offset: 1 } 
    end
  end

  context 'POST /records' do
    it 'creates a new record' do

      expect do
        post '/api/v1/records', params: {
          record: { title: "A Test Pressin", description: "A limited edition record"},
          artist: { name: "A Fake Artist", bio: "Some detailed info about a fake artist"}
        }
      end.to change {Record.count}.by(1)

      expect(response).to have_http_status(:created)
      expect(response_body.first).to eq(
        {
          'id'=> 3,
          'title' => 'A Test Pressin',
          'description' => 'A limited edition record',
          'artist' => {
            'name' => 'A Fake Artist',
            'bio' => 'Some detailed info about a fake artist',
            'artist_id' => 2
          }
        })
    end
  end

  context 'DELETE /records' do
    let!(:artist_one) { FactoryBot.create(:artist, name: "KISS") }
    let!(:record_two) { FactoryBot.create(:record, artist: artist_one, title: "This is a not so great song", description: "Here is some info about a not so great song") }

    it 'deleted a specific record entry' do
      expect do
        delete "/api/v1/records/#{record_one.id}"
      end.to change { Record.count }.by(-1)
       
      expect(response).to have_http_status(:no_content)
    end

  end
end