require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:invoice_items).dependent(:destroy)}
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

    it 'find_some based on name' do 
      merchant = create(:merchant)
      box = create(:item, name: 'box', merchant: @merchant)
      water_bottle = create(:item, name: 'water bottle', merchant: @merchant)
      bo_sox_hat = create(:item, name: 'Boston red sox hat', merchant: @merchant)
      car_jack = create(:item, name: 'car jack', merchant: @merchant)

      expect(Item.find_some(name: 'bo').to_a).to eq([bo_sox_hat, box, water_bottle])
      expect(Item.find_some(name: 'bo')).to_not include(car_jack)
    end

    it 'find_some based on unit_price min' do 
      item_1 = create(:item, unit_price: 3.45, merchant: @merchant)
      item_2 = create(:item, unit_price: 1.34, merchant: @merchant)
      item_3 = create(:item, unit_price: 7.98, merchant: @merchant)
      item_4 = create(:item, unit_price: 8.20, merchant: @merchant)

      expect(Item.find_by_price(min_price: 4.00)).to include(item_3)
      expect(Item.find_by_price(min_price: 4.00)).to include(item_4)
      expect(Item.find_by_price(min_price: 4.00)).to_not include(item_1)
      expect(Item.find_by_price(min_price: 4.00)).to_not include(item_2)
    end

    it 'find_some based on unit_price max' do 
      item_1 = create(:item, unit_price: 3.45, merchant: @merchant)
      item_2 = create(:item, unit_price: 1.34, merchant: @merchant)
      item_3 = create(:item, unit_price: 7.98, merchant: @merchant)
      item_4 = create(:item, unit_price: 8.20, merchant: @merchant)

      expect(Item.find_by_price(max_price: 8.00)).to include(item_1)
      expect(Item.find_by_price(max_price: 8.00)).to include(item_2)
      expect(Item.find_by_price(max_price: 8.00)).to include(item_3)
      expect(Item.find_by_price(max_price: 8.00)).to_not include(item_4)
    end

    it 'find_some based on range' do 
      item_1 = create(:item, unit_price: 3.45, merchant: @merchant)
      item_2 = create(:item, unit_price: 1.34, merchant: @merchant)
      item_3 = create(:item, unit_price: 7.98, merchant: @merchant)
      item_4 = create(:item, unit_price: 8.20, merchant: @merchant)

      expect(Item.find_by_price(min_price: 4.00, max_price: 8.00)).to include(item_3)
      expect(Item.find_by_price(min_price: 4.00, max_price: 8.00)).to_not include(item_1)
      expect(Item.find_by_price(min_price: 4.00, max_price: 8.00)).to_not include(item_2)
      expect(Item.find_by_price(min_price: 4.00, max_price: 8.00)).to_not include(item_4)
    end

    it 'find_some but no result' do 
      # expect(Item.find_some(name: '')).to eq(nil)
      expect(Item.find_some(min_price: nil)).to eq(nil)
      expect(Item.find_some(max_price: nil)).to eq(nil)
      expect(Item.find_some(min_price: nil, max_price: nil)).to eq(nil)
    end

    it '#find_name based on name' do 
      merchant = create(:merchant)
      box = create(:item, name: 'box', merchant: @merchant)
      water_bottle = create(:item, name: 'water bottle', merchant: @merchant)
      bo_sox_hat = create(:item, name: 'Boston red sox hat', merchant: @merchant)
      car_jack = create(:item, name: 'car jack', merchant: @merchant)

      expect(Item.find_name('bo').to_a).to eq([bo_sox_hat, box, water_bottle])
      expect(Item.find_name('bo')).to_not include(car_jack)
    end

    it 'retrieves items based on max_price' do 
      item_1 = create(:item, unit_price: 3.45, merchant: @merchant)
      item_2 = create(:item, unit_price: 1.34, merchant: @merchant)
      item_3 = create(:item, unit_price: 7.98, merchant: @merchant)
      item_4 = create(:item, unit_price: 8.20, merchant: @merchant)

      expect(Item.find_by_price(max_price: 8.00)).to include(item_1)
      expect(Item.find_by_price(max_price: 8.00)).to include(item_2)
      expect(Item.find_by_price(max_price: 8.00)).to include(item_3)
      expect(Item.find_by_price(max_price: 8.00)).to_not include(item_4)
    end

    it 'retrieves items based on min_price' do 
      item_1 = create(:item, unit_price: 3.45, merchant: @merchant)
      item_2 = create(:item, unit_price: 1.34, merchant: @merchant)
      item_3 = create(:item, unit_price: 7.98, merchant: @merchant)
      item_4 = create(:item, unit_price: 8.20, merchant: @merchant)

      expect(Item.find_by_price(min_price: 4.00)).to include(item_3)
      expect(Item.find_by_price(min_price: 4.00)).to include(item_4)
      expect(Item.find_by_price(min_price: 4.00)).to_not include(item_1)
      expect(Item.find_by_price(min_price: 4.00)).to_not include(item_2)
    end

    it 'retrieves items between prices' do 
      item_1 = create(:item, unit_price: 3.45, merchant: @merchant)
      item_2 = create(:item, unit_price: 1.34, merchant: @merchant)
      item_3 = create(:item, unit_price: 7.98, merchant: @merchant)
      item_4 = create(:item, unit_price: 8.20, merchant: @merchant)

      expect(Item.find_by_price(min_price: 4.00, max_price: 8.00)).to include(item_3)
      expect(Item.find_by_price(min_price: 4.00, max_price: 8.00)).to_not include(item_1)
      expect(Item.find_by_price(min_price: 4.00, max_price: 8.00)).to_not include(item_2)
      expect(Item.find_by_price(min_price: 4.00, max_price: 8.00)).to_not include(item_4)
    end
  end
end