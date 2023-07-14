require 'rails_helper'

RSpec.describe 'Find Items' do
  before(:each) do
    @merchant = create(:merchant)
    # create_list(:item, 8, merchant: @merchant)
    @item_1 = create(:item, name: 'water bottle', merchant: @merchant, unit_price: 1.34)
    @item_2 = create(:item, name: 'box', merchant: @merchant, unit_price: 7.90)
    @item_3 = create(:item, name: 'Boston red sox hat', merchant: @merchant, unit_price: 10.25)
    @item_4 = create(:item, name: 'car jack', merchant: @merchant, unit_price: 11.20)
  end

  describe 'search for items' do
    it 'hits the endpoint' do 
      query_params = {
        name: 'bo'
      }

      get '/api/v1/items/find_all', params: query_params

      expect(response).to be_successful
    end

    it 'returns items by name if found' do 
      query_params = {
        name: 'bo'
      }

      get '/api/v1/items/find_all', params: query_params
      
      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      
      items = json[:data]
      expect(items).to be_an Array
      
      items.each do |item|
        expect(item).to be_a Hash
        # expect(item[:id]).to eq()
      end
    end
    
    it 'min price' do 
      query_params = {
        min_price: 7.80
      }
      
      get '/api/v1/items/find_all', params: query_params

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

    end
    
    it 'between price'

    it 'max price' 

    it ''
  end
end