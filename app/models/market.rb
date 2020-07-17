class Market < ApplicationRecord
  has_many :market_products
  has_many :products, through: :market_products
end
