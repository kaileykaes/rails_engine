require 'rails_helper'

RSpec.describe 'Items endpoints' do
  before(:each) do
    @merchant = create(:merchant)
  end

  describe 'relationships' do
    it 'sends a list of all items' do
      create_list(:item, 4, merchant: @merchant)
      get '/api/v1/items'

      expect(response).to be_successful 

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items.count).to eq(4)

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an Integer

        expect(item).to have_key(:name)
        expect(item[:name]).to be_a String
      end
    end

    it 'sends an empty array if no data' do 
      get '/api/v1/items'
      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items.count).to eq(0)
      expect(items.class).to be_an Array
    end

    it 'sends an array if one piece data' do 
      create(:item, merchant: @merchant)
      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items.count).to eq(1)
      expect(items.class).to be_an Array
    end

    it 'sends an empty array if no data' do 
      get '/api/v1/items'
      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items.count).to eq(0)
      expect(items.class).to be_an Array
    end
  end
end