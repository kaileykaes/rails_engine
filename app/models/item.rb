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
end