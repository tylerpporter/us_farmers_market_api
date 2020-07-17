class Product < ApplicationRecord
  has_many :market_products
  has_many :markets, through: :market_products
end