require 'rails_helper'

describe 'Likes API', type: :request do

  context "GET /likes for user" do
    let!(:user) { FactoryBot.create(:user, username: "Me", password: "password") }
    let!(:eddie) { FactoryBot.create(:artist, name: "Eddie Murphy", favourite_count: 10) }
    let!(:record) {FactoryBot.create(:record, title: "Party all the time", description: "Classic 80s pop anthem", genre: "pop", album: "How could it be", artwork_url: "", like_count: 667, artist: eddie) }
    let!(:like) { FactoryBot.create(:like, user: user, record: record) }
    let!(:record_two) {FactoryBot.create(:record, title: "Eddie does it", description: "Classic 80s pop anthem", genre: "pop", album: "How could it be", artwork_url: "", like_count: 667, artist: eddie) }
    let!(:like_two) { FactoryBot.create(:like, user: user, record: record_two) }

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
            'artist' => eddie.name
          }
        },
        {
          'id'=> like_two.id,
          'user_id' => user.id,
          'record' => {
            'title' => record_two.title,
            'artist' => eddie.name
          }
        }
      ])
    end
  end
end