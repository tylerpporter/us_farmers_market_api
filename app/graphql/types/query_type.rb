module Types
  class QueryType < Types::BaseObject
    field :all_markets, [Types::MarketType], null: false
    def all_markets
      Market.all
    end
  end
end
