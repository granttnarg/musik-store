require 'rails_helper'

describe 'Likes API', type: :request do
  let!(:user) { FactoryBot.create(:user, username: "Me", password: "password") }
  let!(:artist) { FactoryBot.create(:artist, name: "Eddie Murphy", favourite_count: 10) }
  let!(:record) {FactoryBot.create(:record, title: "Party all the time", description: "Classic 80s pop anthem", genre: "pop", album: "How could it be", artwork_url: "", like_count: 667, artist: artist) }
  let!(:like) { FactoryBot.create(:like, user: user, record: record) }
  let!(:record_two) {FactoryBot.create(:record, title: "Eddie does it", description: "Classic 80s pop anthem", genre: "pop", album: "How could it be", artwork_url: "", like_count: 667, artist: artist) }
  let!(:like_two) { FactoryBot.create(:like, user: user, record: record_two) }

  context "GET /likes for user" do
    it "should return an array of likes for a given user with the correct auth" do
      get "/api/v1/user/#{user.id}/likes", headers: {"Authorization" => "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSJ9.IdCz91KkIj7SrjjxYTsCiThSTAmJFysugQ5aLZ7O390" }
    
      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(Like.all.size)
      expect(response_body).to eq([
        {
          'id'=> like.id,
          'user_id' => user.id,
          'record' => {
            'title' => record.title,
            'artist' => artist.name
          }
        },
        {
          'id'=> like_two.id,
          'user_id' => user.id,
          'record' => {
            'title' => record_two.title,
            'artist' => artist.name
          }
        }
      ])
    end    
  end

  context "POST delete like" do
    it "It should return a ok and message when a like is removed" do
      delete "/api/v1/likes/#{like.id}", headers: {"Authorization" => "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSJ9.IdCz91KkIj7SrjjxYTsCiThSTAmJFysugQ5aLZ7O390" }
      expect(response).to have_http_status(:ok) 
      expect(response_body).to eq({"status"=>"You have unliked #{record.title} by #{artist .name}"}) 
      
    end 
  end
end