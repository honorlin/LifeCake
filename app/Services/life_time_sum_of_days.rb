class LifeTimeSumOfDays
  def self.call(lives)
    time_sum = {}
    use_date = lives.first.start_time.to_s.split(" ")[0]
    sum_time = 0
    lives.each do |life|
      this_date = life.start_time.to_s.split(" ")[0]
      if use_date != this_date       
        time_sum[use_date] = sum_time
        sum_time = 0
        use_date = this_date
      end
      sum_time += life.spend_time if !life.spend_time.nil?
    end

     time_sum[use_date] = sum_time
     time_sum
  end
end