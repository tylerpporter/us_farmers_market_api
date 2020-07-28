class Market < ApplicationRecord
  has_many :market_products
  has_many :products, through: :market_products

  reverse_geocoded_by :latitude, :longitude

  after_initialize :get_season_dates

  def self.order_by_closest_date(date)
    Market.all.reject do |market|
      market.season1date.nil? ||
      market.season1time.nil? ||
      ("0".."1").exclude?(market.season1date.first) ||
      ("0".."1").exclude?(market.season1date.split(" ").last.first) ||
      market.season1date.split(" ").size == 1
    end.reject do |market|
      market.closest_date = market.closest_date_formatted(date)
      market.closest_date == 'None'
    end.sort_by { |market| market.closest_date_obj(date) }
  end

  def closest_date_formatted(date)
    date_obj = closest_date_obj(date)
    return 'None' if date_obj == 'None'
    date_obj.to_formatted_s(:long)
  end

  def closest_date_obj(date)
    MarketDate.new(self.season1date, self.season1time).find_closest(date)
  end

  private

  def get_season_dates
    self.class_eval do
      attr_accessor :season_dates
      attr_accessor :closest_date
    end
    if season1date.nil? || season1time.nil?
      self.season_dates = "No dates provided for this market."
    elsif ("0".."1").exclude?(season1date.first) ||
    ("0".."1").exclude?(season1date.split(" ").last.first)
      self.season_dates = "#{season1date}, #{season1time}"
    else
      self.season_dates =  "#{start_date} to #{end_date}, #{season1time}"
    end
  end

  def start_date
    date = season1date.split(" ").first
    date[-4..-1] = Time.current.year.to_s
    date
  end

  def end_date
    date = season1date.split(" ").last
    date[-4..-1] = Time.current.year.to_s
    date
  end
end
