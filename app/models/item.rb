class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  validates :name, presence: true
  validates :unit_price, presence: true
  validates :description, presence: true

  def self.find_some(query)
    where("name ILIKE ?", "%#{query}%").order(:name)
  end

  def self.find_by_price(min_price: nil, max_price: nil)
    minimum = min_price.present? ? min_price : 0 
    maximum = max_price.present? ? max_price : 2_000_000
    where("unit_price BETWEEN #{minimum} AND #{maximum}")
  end

  private

  # def self.max_price
  #   maximum(:unit_price)
  # end

  # def self.min_price
  #   minimum(:unit_price)
  # end
end