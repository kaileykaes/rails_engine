class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    begin
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    rescue ActiveRecord::RecordNotFound => error
      render json: ErrorSerializer.new(error).serialize_json, status: 404
    end
  end
end