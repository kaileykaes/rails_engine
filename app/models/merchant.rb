class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  validates :name, presence: true

  def self.find_it(query)
    where("name ILIKE ?", "%#{query}%").first
  end
end