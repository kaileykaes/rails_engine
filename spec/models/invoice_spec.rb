require 'rails_helper'

RSpec.describe Invoice, type: :model do
  # before(:each) do

  # end

  describe 'relationships' do
    it {should belong_to :customer}
    it {should belong_to :merchant}
    it {should have_many :transactions}
  end
end