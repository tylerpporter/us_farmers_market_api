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

    # Return markets by coords
    field :markets_by_coords, Types::ReturnType, null: false do
      argument :lat, Float, required: true
      argument :lng, Float, required: true
      argument :radius, Integer, required: true
      argument :products, [GraphQL::Types::String], required: false
      argument :date, String, required: false
    end
    def markets_by_coords(lat:, lng:, radius:, products: '', date: '')
      markets = Market.near([lat, lng], radius)
      if !products.empty?
        markets = markets.joins(:products)
                         .where(products: { name: products })
                         .group('markets.id')
                         .having('count(distinct products.id) = ?', products.size)
      end
      markets = markets.order_by_closest_date(date) if !date.empty?
      location_object = Geocoder.search([lat, lng]).first
      location = location_object.city + ', ' + location_object.state
      { markets: markets,
        location: location
      }
    end

    # Return markets by city, state
    field :markets_by_city, Types::ReturnType, null: false do
      argument :city, String, required: true
      argument :state, String, required: true
      argument :radius, Integer, required: true
      argument :products, [GraphQL::Types::String], required: false
      argument :date, String, required: false
    end
    def markets_by_city(city:, state:, radius:, products: '', date: '')
      markets = Market.near("#{city}, #{state}", radius)
      if !products.empty?
        markets = markets.joins(:products)
                         .where(products: { name: products })
                         .group('markets.id')
                         .having('count(distinct products.id) = ?', products.size)
      end
      markets = markets.order_by_closest_date(date) if !date.empty?
      coords = Geocoder.search("#{city}, #{state}").first.coordinates
      { markets: markets,
        latitude: coords.first,
        longitude: coords.last
      }
    end

    # Return markets by date
    field :markets_by_date, [Types::MarketType], null: false do
      argument :date, String, required: true
    end
    def markets_by_date(date:)
      Market.order_by_closest_date(date)
    end
  end
end
