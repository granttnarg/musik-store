require 'rails_helper'

describe 'Records API', type: :request do
  let!(:artist) { FactoryBot.create(:artist, name: "George Michael", bio: "Some info about George Michael") }
  let!(:record) { FactoryBot.create(:record, artist: artist, genre: "pop", title: "This is a great song", description: "Here is some info about a great song") }
  let!(:record_one) { FactoryBot.create(:record, artist: artist, genre: "pop", title: "Another Hit", description: "Update info later") }
  
  context 'GET /records' do
    it 'return all records' do
        get '/api/v1/records'

        expect(response).to have_http_status(:success)
        expect(response_body["records"].size).to eq(Record.all.size)
        expect(response_body).to eq(
          {
            "meta"=>
            {
              "total_records"=>2
            },
          "records"=> [
            {
                  'id'=> record.id,
                  'title' => record.title,
                  'description' => record.description,
                  'genre' => record.genre,
                  'album' => nil,
                  'like_count' => nil,
                  'artist' => {
                    'name' => artist.name,
                    'bio' => artist.bio,
                    'artist_id' => artist.id
                  }    
                },
            {
                  'id'=> record_one.id,
                  'title' => record_one.title,
                  'description' => record_one.description,
                  'genre' => record_one.genre,
                  'album' => nil,
                  'like_count' => nil,
                  'artist' => {
                    'name' => artist.name,
                    'bio' => artist.bio,
                    'artist_id' => artist.id
                  }    
                } 
              ]
            }
          )
    end

    it 'it returns a subset of records using pagination limit via params' do
      get '/api/v1/records', params: { limit: 1 } 

      expect(response).to have_http_status(:success)
      expect(response_body["records"].size).to eq(1)
      expect(response_body).to eq({
        "meta"=>
        {
          "total_records"=>1
        },
        "records"=> [
        {
              'id'=> record.id,
              'title' => record.title,
              'description' => record.description,
              'genre' => record.genre,
              'album' => nil,
              'like_count' => nil,
              'artist' => {
                'name' => artist.name,
                'bio' => artist.bio,
                'artist_id' => artist.id
              }    
            }
          ]
        }
      )
    end

    it 'returns a subset of records based on limit and offset' do
      get '/api/v1/records', params: { limit: 1, offset: 1 }
      
      expect(response).to have_http_status(:success)
      expect(response_body["records"].size).to eq(1)
      expect(response_body).to eq(
        {
          "meta"=>
          {
            "total_records"=>1
          },
        "records"=> [
              {
                'id'=> record_one.id,
                'title' => record_one.title,
                'description' => record_one.description,
                'genre' => record_one.genre,
                'album' => nil,
                'like_count' => nil,
                'artist' => {
                  'name' => artist.name,
                  'bio' => artist.bio,
                  'artist_id' => artist.id
                }    
              } 
            ]
          }
        )
    end
  end

  context 'POST /records' do
    let!(:user) { FactoryBot.create(:user, username: "Me", password: "password") }
    let!(:artist) { FactoryBot.create(:artist, name: "George Michael", bio: "Some info about George Michael") }
    let!(:record_params) { { title: "A Test Pressin", description: "A limited edition record", genre: "pop"} }
    it 'creates a new record' do
      expect {
        post "/api/v1/artists/#{artist.id}/records", params: {
          record: record_params
        }, headers: {"Authorization" => "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSJ9.IdCz91KkIj7SrjjxYTsCiThSTAmJFysugQ5aLZ7O390" }
        }.to change {Record.count}.by(1)

      expect(response).to have_http_status(:created)
      expect(response_body).to eq(
          {
            "meta"=>
            {
              "total_records"=>1
            },
          "records"=> [ 
          {
            "id"=>Record.last.id,
            "title"=>record_params[:title],
            "description"=>record_params[:description],
            "genre"=>record_params[:genre],
            "album"=>nil,
            "like_count"=>nil,
            "artist"=>
              {
              "artist_id"=>artist.id, 
              "name"=>artist.name, 
              "bio"=>artist.bio
              }
           }]
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