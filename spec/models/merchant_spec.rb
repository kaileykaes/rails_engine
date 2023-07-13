require 'rails_helper'

RSpec.describe Merchant, type: :model do
  # before(:each) do
  #   create(:merchant)
  #   require 'pry'; binding.pry
  # end

  describe 'relationships' do
    it {should have_many :invoices}
    it {should have_many :items}
  end

  describe 'validations' do 
    it {should validate_presence_of(:name)}
  end

  describe 'class methods' do 
    it 'find_it' do 
      merchant = create(:merchant, name: 'Jeremicah Rue') 
      create_list(:merchant, 10)
      query = 'Jeremicah'
      expect(Merchant.find_it(query)).to eq(merchant)
    end

    it 'find_it returns in case_insensitive alphabetical order' do 
      merchant = create(:merchant, name: 'Ring World')
      merchant_2 = create(:merchant, name: 'Turing')

      query = 'ring'

      expect(Merchant.find_it(query)).to eq(merchant)
    end
  end
end