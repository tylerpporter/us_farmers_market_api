module Types
  class MarketType < Types::BaseObject
    field :id, ID, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :FMID, Integer, null: true
    field :market_name, String, null: true
    field :website, String, null: true
    field :street, String, null: true
    field :city, String, null: true
    field :state, String, null: true
    field :zip, String, null: true
    field :season_1_date, String, null: true
    field :seson_1_time, String, null: true
    field :season_2_date, String, null: true
    field :season_2_time, String, null: true
    field :lat, String, null: true
    field :lng, String, null: true
  end
end
