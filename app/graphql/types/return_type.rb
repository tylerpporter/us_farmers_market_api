module Types
  class ReturnType < Types::BaseObject
    field :markets, [Types::MarketType], null: false
    field :location, String, null: false
  end
end
