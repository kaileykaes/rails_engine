class Api::V1::Merchants::FindController < ApplicationController
  def index 
    render json: MerchantSerializer.new(Merchant.find_it(params[:name]))
  end
end