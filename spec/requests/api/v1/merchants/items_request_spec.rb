require 'rails_helper'

RSpec.describe 'Merchant Items' do
  before(:each) do
    @merchant = create(:merchant)
    @items = create_list(:item, 7, merchant: @merchant)
  end

  describe 'items index' do
    it 'fetch all items' do 
      get "/api/v1/#{@merchant.id}/items"
    end
  end
end