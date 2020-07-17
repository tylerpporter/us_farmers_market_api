module Types
  class QueryType < Types::BaseObject
    field :all_markets, [Types::MarketType], null: false
    def all_markets
      Market.all
    end

    # Save for future use to search markets by products, etc.
    # 
    # field :all_markets, [Types::MarketType], null: false
    # def all_markets
    #   Market.all
    # end

    field :market, Types::MarketType, null: false do
      argument :id, Integer, required: true
    end
    def market(id)
      Market.find(id[:id])
    end
    
  end
end
