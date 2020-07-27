class Market < ApplicationRecord
  has_many :market_products
  has_many :products, through: :market_products

  reverse_geocoded_by :latitude, :longitude

  def self.order_by_closest_date(date)
    filtered = Market.all.reject do |market|
      market.season1date.nil? ||
      market.season1time.nil? ||
      ("0".."1").exclude?(market.season1date.first) ||
      ("0".."1").exclude?(market.season1date.split(" ").last.first) ||
      market.closest_date_obj(date).nil?
    end
    filtered.each do |market|
      market.class_eval do
        attr_accessor :closest_date
      end 
    end
    filtered.each { |market| market.closest_date = market.closest_date_formatted(date) }
    filtered.sort_by { |market| market.closest_date_obj(date) }
  end

  def closest_date_formatted(date)
    closest_date_obj(date).to_formatted_s(:long)
  end

  def market_dates
    MarketDate.new(self.season1date, self.season1time).new.get_dates
  end

  def closest_date_obj(date)
    MarketDate.new(self.season1date, self.season1time).find_closest(date)
  end
end
