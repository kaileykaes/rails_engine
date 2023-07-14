class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  validates :name, presence: true
  validates :unit_price, presence: true
  validates :description, presence: true

  def self.find_some(name: nil, max_price: nil, min_price: nil)
    if max_price == nil && min_price == nil && name != nil 
      self.find_name(name)
    elsif name == nil && max_price != nil || min_price != nil
      self.find_by_price(max_price: max_price, min_price: min_price)
    end
  end

  def self.find_name(name)
    where("name ILIKE ?", "%#{name}%").order(:name)
  end

  def self.find_by_price(min_price: nil, max_price: nil)
    minimum = min_price.present? ? min_price : 0 
    maximum = max_price.present? ? max_price : 2_000_000
    where("unit_price BETWEEN #{minimum} AND #{maximum}")
  end
end