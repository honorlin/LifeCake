module ApplicationHelper

  def time_diff(start_time, end_time)

    seconds_diff = (start_time - end_time).to_i.abs

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    "#{hours.to_s}小時 #{minutes.to_s}分"
  end

  def show_time(seconds_diff)
    return if seconds_diff.blank?
    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    "#{hours.to_s}小時 #{minutes.to_s}分"
  end

end
