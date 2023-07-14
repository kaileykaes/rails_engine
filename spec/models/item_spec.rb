require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:transactions).through(:invoices)}
  end

  describe 'validations' do 
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:unit_price)}
    it {should validate_presence_of(:description)}
  end

  describe 'class methods' do 
    before(:each) do 
      @merchant = create(:merchant)
    end

    it 'retrieves items based on name' do 
      merchant = create(:merchant)
      create_list(:item, 8, merchant: @merchant)
      item_1 = create(:item, name: 'box', merchant: @merchant)
      item_2 = create(:item, name: 'water bottle', merchant: @merchant)
      item_3 = create(:item, name: 'Boston red sox hat', merchant: @merchant)
      item_4 = create(:item, name: 'car jack', merchant: @merchant)

      query = 'bo'

      expect(Item.find_some(query)).to eq([item_3, item_1, item_2])
      expect(Item.find_some(query)).to_not include(item_4)
    end

    it 'retrieves items based on max_price' do 
      item_1 = create(:item, unit_price: 3.45, merchant: @merchant)
      item_2 = create(:item, unit_price: 1.34, merchant: @merchant)
      item_3 = create(:item, unit_price: 7.98, merchant: @merchant)
      item_4 = create(:item, unit_price: 8.20, merchant: @merchant)

      
    end
  end
end

# it 'find_it' do
#   merchant = create(:merchant, name: 'Jeremicah Rue') 
#   create_list(:merchant, 10)
#   query = 'Jeremicah'
#   expect(Merchant.find_it(query)).to eq(merchant)
# end

# it 'find_it returns in case_insensitive alphabetical order' do 
#   merchant_2 = create(:merchant, name: 'Turing')
#   merchant = create(:merchant, name: 'Ring World')

#   query = 'ring'

#   expect(Merchant.find_it(query)).to eq(merchant)
# end
# end