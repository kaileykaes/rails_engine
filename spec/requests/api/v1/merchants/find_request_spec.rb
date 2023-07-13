require 'rails_helper'

RSpec.describe 'Find a Merchant' do
  before(:each) do
    @merchant = create(:merchant, name: 'Jeremicah Rue')
  end

  describe 'search for a merchant' do
    it 'returns a merchant by query' do 
      query_params = {
        name: 'ru'
      }
      get '/api/v1/find', params: query_params

      expect(response).to be_successful
    end
  end
end