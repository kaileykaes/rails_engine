require 'rails_helper'

RSpec.describe 'Find Items' do
  before(:each) do
    @merchant = create(:merchant)
    create_list(:item, 8, merchant: @merchant)
    @item_1 = create(:item, name: 'water bottle', merchant: @merchant)
    @item_2 = create(:item, name: 'box', merchant: @merchant)
    @item_2 = create(:item, name: 'Boston red sox hat', merchant: @merchant)
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

      item = json[:data]
      require 'pry'; binding.pry
      expect(response).to be_a Array
    end
  end
end