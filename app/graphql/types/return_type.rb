module Types
  class ReturnType < Types::BaseObject
    field :markets, [Types::MarketType], null: false
    field :location, String, "The city, state for the request lat, lng.", null: true
    field :latitude, Float, "The latitude for the request city, state.", hash_key: 'latitude', null: true
    field :longitude, Float, "The longitude for the request city, state.", hash_key: 'longitude', null: true
  end
end
