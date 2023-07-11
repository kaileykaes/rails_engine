require 'rails_helper'

RSpec.describe 'Merchants API' do
  # before(:each) do
    
  # end

  describe 'merchants endpoints' do
    it 'sends a list of all merchants' do
      create_list(:merchant, 4)
      get '/api/v1/merchants'

      expect(response).to be_successful 

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants.count).to eq(4)

      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an Integer

        expect(merchant).to have_key(:name)
        expect(merchant[:name]).to be_a String
      end
    end

    it 'sends an empty array if no data' do 
      get '/api/v1/merchants'
      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants.count).to eq(0)
      expect(merchants.class).to be_an Array
    end

    it 'sends an array if one piece data' do 
      create(:merchant)
      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants.count).to eq(1)
      expect(merchants.class).to be_an Array
    end

    it 'sends an empty array if no data' do 
      get '/api/v1/merchants'
      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants.count).to eq(0)
      expect(merchants.class).to be_an Array
    end
  end
end