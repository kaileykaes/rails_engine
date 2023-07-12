require 'rails_helper'

RSpec.describe 'Items endpoints' do
  before(:each) do
    @merchant = create(:merchant)
  end

  describe 'index' do 
    it 'sends a list of all items' do
      create_list(:item, 4, merchant: @merchant)
      get '/api/v1/items'

      expect(response).to be_successful 

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a Hash
      expect(json).to have_key(:data)
      expect(json[:data]).to be_a Array
      expect(json[:data].count).to eq(4)

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

    it 'sends an empty array if no data' do 
      get '/api/v1/items'
      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a Hash
      expect(json).to have_key(:data)
      expect(json[:data]).to be_a Array
      expect(json[:data].count).to eq(0)
      expect(json[:data].empty?).to be true
    end

    it 'sends an array if one piece data' do 
      create(:item, merchant: @merchant)
      get '/api/v1/items'

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a Hash
      expect(json).to have_key(:data)
      expect(json[:data]).to be_a Array
      expect(json[:data].count).to eq(1)

      one_item = json[:data].first

      expect(one_item).to have_key(:id)
      expect(one_item[:id]).to be_a String

      expect(one_item).to have_key(:type)
      expect(one_item[:type]).to be_a String
      expect(one_item[:type]).to eq('item')

      expect(one_item).to have_key(:attributes)
      expect(one_item[:attributes]).to be_a Hash

      attributes = one_item[:attributes]
      keys = [:name, :description]
      keys.each do |key|
        expect(attributes).to have_key(key)
        expect(attributes[key]).to be_a String
      end

      expect(attributes).to have_key(:unit_price)
      expect(attributes[:unit_price]).to be_a Float

      expect(attributes).to have_key(:merchant_id)
      expect(attributes[:merchant_id]).to be_a Integer
    end
  end

  describe 'show' do 
    it 'sends a specific item' do 
      item = create(:item, merchant: @merchant)

      get "/api/v1/items/#{item.id}"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a Hash
      expect(json).to have_key(:data)
      expect(json[:data]).to be_a Hash

      show_item = json[:data]

      expect(show_item).to have_key(:id)
      expect(show_item[:id]).to be_a String

      expect(show_item).to have_key(:type)
      expect(show_item[:type]).to be_a String
      expect(show_item[:type]).to eq('item')

      expect(show_item).to have_key(:attributes)
      expect(show_item[:attributes]).to be_a Hash

      attributes = show_item[:attributes]
      keys = [:name, :description]
      keys.each do |key|
        expect(attributes).to have_key(key)
        expect(attributes[key]).to be_a String
      end

      expect(attributes).to have_key(:unit_price)
      expect(attributes[:unit_price]).to be_a Float

      expect(attributes).to have_key(:merchant_id)
        expect(attributes[:merchant_id]).to be_a Integer
    end

    it 'bad integer returns 404'
  end
end