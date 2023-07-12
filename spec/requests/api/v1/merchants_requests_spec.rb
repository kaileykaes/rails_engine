require 'rails_helper'

RSpec.describe 'Merchants API' do
  describe 'merchants endpoints' do
    describe 'index' do 
      it 'sends a list of all merchants' do
        create_list(:merchant, 4)
        get '/api/v1/merchants'

        expect(response).to be_successful 

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json).to have_key(:data)
        expect(json[:data]).to be_a Array
        expect(json[:data].count).to eq(4)

        merchants = json[:data]

        merchants.each do |merchant|
          expect(merchant).to have_key(:id)
          expect(merchant[:id]).to be_a String

          expect(merchant).to have_key(:type)
          expect(merchant[:type]).to be_a String
          expect(merchant[:type]).to eq('merchant')

          expect(merchant).to have_key(:attributes)
          expect(merchant[:attributes]).to be_a Hash

          expect(merchant[:attributes]).to have_key(:name)
          expect(merchant[:attributes][:name]).to be_a String
        end
      end

      it 'sends an empty array if no data' do 
        get '/api/v1/merchants'
        expect(response).to be_successful

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json).to have_key(:data)
        expect(json[:data]).to be_a Array
        expect(json[:data].count).to eq(0)
        expect(json[:data].empty?).to be true
      end

      it 'sends an array if one piece data' do 
        create(:merchant)
        get '/api/v1/merchants'

        expect(response).to be_successful

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json).to have_key(:data)
        expect(json[:data]).to be_a Array
        expect(json[:data].count).to eq(1)

        merchant = json[:data].first

        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a String

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_a String
        expect(merchant[:type]).to eq('merchant')

        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_a Hash

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a String
      end
    end

    describe 'show' do 
      it 'sends a specific merchant' do 
        merchant = create(:merchant)

        get "/api/v1/merchants/#{merchant.id}"
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json).to have_key(:data)
        expect(json[:data]).to be_a Hash

        merchant = json[:data]

        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a String

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_a String
        expect(merchant[:type]).to eq('merchant')

        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_a Hash

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a String
      end
    end
  end
end