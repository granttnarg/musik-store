require 'rails_helper'

describe 'Records API', type: :request do
  it 'return all records' do
    FactoryBot.create(:record, title: "This is a great song", description: "Here is some info about a great song")
    
    get '/api/v1/records'

    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body).size).to eq(Record.all.size)
  end
end