require 'rails_helper'

describe 'Records API', type: :request do
  let!(:artist) { FactoryBot.create(:artist, name: "George Michael", bio: "Some info about George Michael") }
  let!(:record) { FactoryBot.create(:record, artist: artist, genre: "pop", title: "This is a great song", description: "Here is some info about a great song") }
  let!(:record_one) { FactoryBot.create(:record, artist: artist, genre: "pop", title: "Another Hit", description: "Update info later") }
  
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
            'genre' => 'pop',
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
            'genre' => 'pop',
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
          'genre' => 'pop',
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
            'genre' => 'pop',
            'artist' => {
              'name' => 'George Michael',
              'bio' => 'Some info about George Michael',
              'artist_id' => 1
            }    
          }
      ])
    end
  end

  context 'POST /records' do
    let!(:user) { FactoryBot.create(:user, username: "Me", password: "password") }
    it 'creates a new record' do
      expect {
        post '/api/v1/records', params: {
          record: { title: "A Test Pressin", description: "A limited edition record", genre: "pop"},
          artist: { name: "A Fake Artist", bio: "Some detailed info about a fake artist"}
        }, headers: {"Authorization" => "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSJ9.IdCz91KkIj7SrjjxYTsCiThSTAmJFysugQ5aLZ7O390" }
        }.to change {Record.count}.by(1)

      expect(response).to have_http_status(:created)
      expect(response_body.first).to eq(
        {
          'id'=> 3,
          'title' => 'A Test Pressin',
          'description' => 'A limited edition record',
          'genre' => 'pop',
          'artist' => {
            'name' => 'A Fake Artist',
            'bio' => 'Some detailed info about a fake artist',
            'artist_id' => 2
          }
        })
    end
  end

  context 'DELETE /records' do
    let!(:user) { FactoryBot.create(:user, username: "Me", password: "password") }
    let!(:artist_one) { FactoryBot.create(:artist, name: "KISS") }
    let!(:record_two) { FactoryBot.create(:record, artist: artist_one, genre: "rock", title: "This is a not so great song", description: "Here is some info about a not so great song") }

    it 'deleted a specific record entry' do
      expect do
        delete "/api/v1/records/#{record_one.id}", headers: {"Authorization" => "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSJ9.IdCz91KkIj7SrjjxYTsCiThSTAmJFysugQ5aLZ7O390" }
      end.to change { Record.count }.by(-1)
       
      expect(response_body).to eq({ "status" => "Record succesfully deleted" })
    end

  end
end