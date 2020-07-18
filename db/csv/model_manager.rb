require_relative 'farmers_market_generator.rb'

class ModelManager
  class << self
    def destroy_and_create_markets(csv = File.open('db/csv/markets.csv'))
      MarketProduct.destroy_all
      Product.destroy_all
      Market.destroy_all
      markets = FarmersMarketGenerator.new(csv)
      markets.import
    end
  end
end
