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
    field :markets_by_location, [Types::MarketType], null: false do
      argument :lat, Float, required: true
      argument :lng, Float, required: true
      argument :radius, Integer, required: true
    end
    def markets_by_location(lat:, lng:, radius:)
      Market.near([lat, lng], radius)
    end
  end
end
