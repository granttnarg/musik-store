require 'rails_helper'

RSpec.describe Api::V1::RecordsController, type: :controller do
  it 'returns records with a max limit fo 100' do
    expect(Record).to receive(:limit).with(100).and_call_original 
    
    get :index, params: { limit: 999 } 
  end
end