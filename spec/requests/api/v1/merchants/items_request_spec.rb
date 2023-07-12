require 'rails_helper'

RSpec.describe 'Merchant Items' do
  before(:each) do
    @merchant = create(:merchant)
    @items = create_list(:item, 7, merchant: @merchant)
  end

  describe 'items index' do
    it 'fetch all items' do 
      get  api_v1_merchant_items_path(@merchant)
      expect(response).to be_successful
      
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a Hash
      expect(json).to have_key(:data)
      expect(json[:data]).to be_a Array
      expect(json[:data].count).to eq(7)

      items = json[:data]
      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a String

        expect(item).to have_key(:type)
        expect(item[:type]).to be_a String
        expect(item[:type]).to eq('item')

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a Hash

        
        attributes = item[:attributes]

        expect(attributes).to have_key(:unit_price)
        expect(attributes[:unit_price]).to be_a Float

        expect(attributes).to have_key(:merchant_id)
        expect(attributes[:merchant_id]).to be_a Integer
        
        keys = [:name, :description]
        keys.each do |key|
          expect(attributes).to have_key(key)
          expect(attributes[key]).to be_a String
        end
      end
    end
  end
end