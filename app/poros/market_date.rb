class MarketDate
  WEEKDAYS = Date::ABBR_DAYNAMES.zip(Date::DAYNAMES).to_h
  attr_reader :season1date, :season1time

  def initialize(season1date, season1time)
    @season1date = season1date
    @season1time = season1time
  end

  def get_dates
    (start_date..end_date).select do |date|
      dow = day_of_week(date)
      date.public_send(dow) if dow != nil
    end
  end

  def find_closest(req_date)
    future_dates(req_date).sort_by do |date|
      date.to_time - date_obj(req_date).to_time
    end.first
  end

  private

  def future_dates(req_date)
    get_dates.reject { |date| date.to_time < date_obj(req_date).to_time }
  end

  def date_obj(date)
    Date.strptime(date, "%m/%d/%Y")
  end

  def day_of_week(date)
    full_daynames.select {|day| date.public_send(day)}.first
  end

  def full_daynames
    abbr_daynames.map { |d| WEEKDAYS[d].downcase << "?" }
  end

  def abbr_daynames
    @season1time.split(";").map { |times| times.split(":") }.map(&:first)
  end

  def start_date
    date= @season1date.split(" ").first
    date[-4..-1] = Time.current.year.to_s
    date_obj(date)
  end

  def end_date
    date = @season1date.split(" ").last
    date[-4..-1] = Time.current.year.to_s
    date_obj(date)
  end
end
