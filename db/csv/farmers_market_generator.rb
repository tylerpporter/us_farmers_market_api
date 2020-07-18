require 'csv'

class FarmersMarketGenerator
  def initialize(csv)
    @csv = csv
  end

  def import
    create_products
    create_markets
  end

  private

  def create_markets
    CSV.foreach(@csv, headers: true, header_converters: :symbol) do |row|
      csv_market = row.to_h
      market = Market.create(market_params(csv_market))
      create_market_products(csv_market, market)
    end
  end

  def create_market_products(csv_market, market)
    product_ids(csv_market).each do |id|
      MarketProduct.create(market_id: market.id, product_id: id)
    end
  end

  def product_ids(csv_market)
    Product.where(name: market_products(csv_market)).ids
  end

  def market_products(csv_market)
    csv_market.select { |k, v| v == 'Y' && product_list.include?(k) }.keys
  end

  def create_products
    product_list.each { |product| Product.create(name: product) }
  end

  def product_list
    %i(organic
       bakedgoods
       cheese
       crafts
       flowers
       eggs
       seafood
       herbs
       vegetables
       honey
       jams
       maple
       meat
       nursery
       nuts
       plants
       poultry
       prepared
       soap
       trees
       wine
       coffee
       beans
       fruits
       grains
       juices
       mushrooms
       petfood
       tofu
       wildharvested
     )
  end

  def market_params(csv_market)
    {
      fmid: csv_market[:fmid],
      marketname: csv_market[:marketname],
      website: csv_market[:website],
      street: csv_market[:street],
      city: csv_market[:city],
      state: csv_market[:state],
      zip: csv_market[:zip],
      season1date: csv_market[:season1date],
      season1time: csv_market[:season1time],
      season2date: csv_market[:season2date],
      season2time: csv_market[:season2time],
      latitude: csv_market[:y],
      longitude: csv_market[:x]
    }
  end
end
