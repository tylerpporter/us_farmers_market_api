module Types
  class ReturnType < Types::BaseObject
    field :markets, [Types::MarketType], null: false
    field :location, String, null: true
    field :latitude, Float, hash_key: 'latitude', null: true
    field :longitude, Float, hash_key: 'longitude', null: true
  end
end
