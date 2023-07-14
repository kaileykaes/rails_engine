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

    it 'returns first object, case-insensitive alpha, if multiple matches' do 
      merchant_1 = create(:merchant, name: 'Turing')
      merchant_2 = create(:merchant, name: 'Ring World')

      query_params = {
        name: 'ring'
      }
      get '/api/v1/merchants/find', params: query_params

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      merchant = json[:data]

      expect(merchant[:type]).to eq('merchant')
      expect(merchant[:id]).to eq("#{merchant_2.id}")
    end

    it 'no fragment matched, still sends object' 
  end
end