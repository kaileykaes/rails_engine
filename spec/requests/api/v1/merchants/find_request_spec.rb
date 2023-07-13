require 'rails_helper'

RSpec.describe 'Find a Merchant' do
  before(:each) do
    @merchant = create(:merchant, name: 'Jeremicah Rue')
  end

  describe 'search for a merchant' do
    it 'returns a single object, if found' do 
      query_params = {
        name: 'ru'
      }
      get '/api/v1/merchants/find', params: query_params

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      merchant = json[:data]

      expect(merchant[:type]).to eq('merchant')
      expect(merchant[:id]).to eq("#{@merchant.id}")
    end
  end
end