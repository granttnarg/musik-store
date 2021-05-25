require 'rails_helper'

RSpec.describe Api::V1::LikesController, type: :controller do
    let!(:user) { FactoryBot.create(:user, username: "Me", password: "password") }
    let!(:eddie) { FactoryBot.create(:artist, name: "Eddie Murphy", favourite_count: 10) }
    let!(:record) {FactoryBot.create(:record, title: "Party all the time", description: "Classic 80s pop anthem", genre: "pop", album: "How could it be", artwork_url: "", like_count: 667, artist: eddie) }
    let!(:like) { FactoryBot.create(:like, user: user, record: record) }

  context 'GET index' do
    let!(:record_two) {FactoryBot.create(:record, title: "Eddie does it", description: "Classic 80s pop anthem", genre: "pop", album: "How could it be", artwork_url: "", like_count: 667, artist: eddie) }
    let!(:like_two) { FactoryBot.create(:like, user: user, record: record_two) }

    it '' do
      # request.headers["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSJ9.IdCz91KkIj7SrjjxYTsCiThSTAmJFysugQ5aLZ7O390" 
      # get :index, params: { limit: 999, user_id: user.id }

    end
  end

  context 'POST create' do
    it 'creates a like linked to current user and an artist' do
      request.headers["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSJ9.IdCz91KkIj7SrjjxYTsCiThSTAmJFysugQ5aLZ7O390"
      expect { post :create, params: {
        record_id: record.id
        }
      }.to change{ Like.count }.by(1)
    end  
  end
end
