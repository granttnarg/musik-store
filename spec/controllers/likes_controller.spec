require 'rails_helper'

RSpec.describe Api::V1::LikesController, type: :controller do
    let!(:user) { FactoryBot.create(:user, username: "Me", password: "password") }
    let!(:eddie) { FactoryBot.create(:artist, name: "Eddie Murphy", favourite_count: 10) }
    let!(:record) {FactoryBot.create(:record, title: "Party all the time", description: "Classic 80s pop anthem", genre: "pop", album: "How could it be", artwork_url: "", like_count: 667, artist: eddie) }
    let!(:like) { FactoryBot.create(:like, user: user, record: record) }

  context 'POST create' do
    it 'creates a like linked to current user and an artist' do
      request.headers["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Ik1lIn0.se5D8jyHoEwVnR-t2qivsTzTXFW5QsMgncTrAoenSYM"
      expect { post :create, params: {
        record_id: record.id
        }
      }.to change{ Like.count }.by(1)
    end

    it 'does not change like count with invalid record id' do
      request.headers["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Ik1lIn0.se5D8jyHoEwVnR-t2qivsTzTXFW5QsMgncTrAoenSYM"
      expect { post :create, params: {
        record_id: 99
        }
      }.to change{ Like.count }.by(0)
    end
    
    
  end
end
