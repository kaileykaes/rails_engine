require 'rails_helper'

RSpec.describe Merchant, type: :model do
  # before(:each) do

  # end

  describe 'relationships' do
    it {should have_many :invoices}
    it {should have_many :items}
  end
end