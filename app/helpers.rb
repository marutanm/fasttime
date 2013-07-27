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

  def left_time(stamps)
    total_time = stamps.values.inject(0){|total, s| total + s.working_time }.to_f

    now = Time.now
    working_time_today = stamps[now.day].working_time.to_f rescue 0
    time_to_work = (weekdays * 8.hours).to_f

    left = {}
    left[:total] = (time_to_work - total_time) / time_to_work * 100
    left[:today] = working_time_today / time_to_work * 100
    left[:until_yesterday] = left[:total] + left[:today]
    OpenStruct.new left
  end

end

FastTime::App.helpers AppHelper
