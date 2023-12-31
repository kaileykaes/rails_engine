class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    response = render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    render json: ItemSerializer.new(Item.create!(item_params)), status: :created
  end

  def update
    render json: (ItemSerializer.new(Item.update!(params[:id], item_params))) 
  end

  def destroy
    item = Item.find(params[:id])
    if item.invoices.count == 1
      invoice = item.invoices.first
      item.destroy
      invoice.destroy if invoice.invoice_items.count == 0 
    else
      item.destroy
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end