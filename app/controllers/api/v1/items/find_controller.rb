class Api::V1::Items::FindController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.find_some(name: params[:name], min_price: params[:min_price], max_price: params[:max_price]))
  end
end