module Types
  class QueryType < Types::BaseObject
    # Return all markets
    field :all_markets, [Types::MarketType], null: false
    def all_markets
      Market.all
    end
    # Return a single market by id
    field :market, Types::MarketType, null: false do
      argument :id, Integer, required: true
    end
    def market(id:)
      Market.find(id)
    end
    # Return markets by location
    field :markets_by_location, Types::ReturnType, null: false do
      argument :lat, Float, required: true
      argument :lng, Float, required: true
      argument :radius, Integer, required: true
      argument :products, [GraphQL::Types::String], required: false
    end
    def markets_by_location(lat:, lng:, radius:, products: '')
      markets = Market.near([lat, lng], radius)
      if !products.empty?
        markets = markets.joins(:products)
                         .where(products: { name: products })
                         .group('markets.id')
                         .having('count(distinct products.id) = ?', products.size)
      end
      location_object = Geocoder.search([lat, lng]).first
      location = location_object.city + ', ' + location_object.state
      { markets: markets,
        location: location
      }
    end
  end
end
