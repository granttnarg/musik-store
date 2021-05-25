require 'rails_helper'

RSpec.describe Api::V1::LikesController, type: :controller do
  context 'GET index' do
  end

  context 'POST create' do
    let!(:user) { FactoryBot.create(:user, username: "Me", password: "password") }
    let!(:eddie) { FactoryBot.create(:artist, name: "Eddie Murphy", favourite_count: 10) }
    let!(:record) {FactoryBot.create(:record, title: "Party all the time", description: "Classic 80s pop anthem", genre: "pop", album: "How could it be", artwork_url: "", like_count: 667, artist: eddie) }

    
    it 'creates a like linked to current user and an artist' do
      post :create, params: {
        record_id: record.id
      }
      binding.pry
    end  
  end
end