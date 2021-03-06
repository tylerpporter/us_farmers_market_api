module Types
  class MarketType < Types::BaseObject
    field :id, ID, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :fmid, Integer, null: true
    field :marketname, String, null: true
    field :website, String, null: true
    field :street, String, null: true
    field :city, String, null: true
    field :state, String, null: true
    field :zip, String, null: true
    field :season1date, String, null: true
    field :season1time, String, null: true
    field :season2date, String, null: true
    field :season2time, String, null: true
    field :latitude, Float, null: true
    field :longitude, Float, null: true
    field :products, [Types::ProductType], null: false
    field :distance, Float, "The market's distance away in miles from the request location.", null: true
    field :closest_date, String, "The market's closest open date to the request date.", null: true
    field :season_dates, String, null: false
  end
end
