require_relative 'farmers_market_generator.rb'

class ModelGenerator
  class << self
    def destroy_and_create
      Product.destroy_all
      Market.destroy_all
      markets = FarmersMarketGenerator.new
      markets.import
    end
  end
end
