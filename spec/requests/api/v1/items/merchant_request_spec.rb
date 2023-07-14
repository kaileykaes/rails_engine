require 'rails_helper'

RSpec.describe 'Item Merchant' do
  before(:each) do
    @merchant = create(:merchant)
    @item = create(:item, id: 1, merchant: @merchant)
  end

  describe 'item merchant show' do
    it 'fetch one merchant by id' do 
      get  "/api/v1/items/#{@item.id}/merchant"
      expect(response).to be_successful
      
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

    it 'bad integer id returns 404' 

    it 'edge case, string id returns 404'
  end
end