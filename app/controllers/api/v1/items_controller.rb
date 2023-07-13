class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    render json: ItemSerializer.new(Item.create!(item_params)), status: :created
  end

  def update
    render json: (ItemSerializer.new(Item.update!(item_params))) 
  end

  def destroy
    item = Item.find(params[:id])
    begin
      item.destroy
    rescue ActiveRecord::InvalidForeignKey => e
      if item.invoices.count == 1
        invoice = item.invoices.first
        item.invoice_items.each do |invoice_item|
          invoice_item.destroy
        end
        invoice.destroy if invoice.invoice_items.count == 0 
        item.destroy
      else
        item.destroy
        item.invoice_items.each do |invoice_item|
          invoice_item.destroy
        end   
        item.destroy
      end
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end