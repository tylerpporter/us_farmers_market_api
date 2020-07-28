class MarketDate
  WEEKDAYS = Date::ABBR_DAYNAMES.zip(Date::DAYNAMES).to_h
  attr_reader :season1date, :season1time

  def initialize(season1date, season1time)
    @season1date = season1date
    @season1time = season1time
  end

  def get_dates
    if day_started.to_time > day_ended.to_time
      start_day, end_day = day_ended, day_started
    else
      start_day, end_day = day_started, day_ended
    end
    (start_day..end_day).select do |date|
      dow = day_of_week(date)
      date.public_send(dow) if dow != nil
    end
  end

  def find_closest(req_date)
    if future_dates(req_date).empty?
      return 'None'
    end
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

  def day_started
    date= @season1date.split(" ").first
    date[-4..-1] = Time.current.year.to_s
    date.gsub!("31", "30")
    date_obj(date)
  end

  def day_ended
    date = @season1date.split(" ").last
    date[-4..-1] = Time.current.year.to_s
    date.gsub!("31", "30")
    date_obj(date)
  end
end
