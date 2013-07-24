# Helper methods defined here can be accessed in any controller or view in the application

module AppHelper
  def weekdays(year = nil, month = nil)
    now = Time.now
    year = now.year unless year
    month = now.month unless month

    first_day = Date.new year, month, 1
    last_day = Date.new year, month, -1

    days = (first_day..last_day).to_a
    days.delete_if {|day| day.saturday?}
    days.delete_if {|day| day.sunday?}
    days.delete_if {|day| day.holiday?}
    days.count
  end

  def format_time(time)
    hour, mod = time.divmod 1.hour
    min = mod / 1.minute
    if time > 0 then
      format("%02d:%02d", hour, min)
    else
      '-'
    end
  end

end

FastTime::App.helpers AppHelper
