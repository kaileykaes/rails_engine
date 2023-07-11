require 'rails_helper'

RSpec.describe 'Merchants API' do
  # before(:each) do
    
  # end

  describe 'merchants endpoints' do
    describe 'index' do 
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

      it 'sends an array if no data' do 
        get '/api/v1/merchants'
        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(merchants.count).to eq(0)
        expect(merchants.class).to be_an Array
      end
    end

    describe 'show' do 
      it 'sends a specific merchant' do 
        merchant = create(:merchant)

        get "/api/v1/merchants/#{merchant.id}"
        the_merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(the_merchant[:id]).to eq(merchant.id)
        expect(the_merchant[:name]).to eq(merchant.name)
      end
    end
  end
end