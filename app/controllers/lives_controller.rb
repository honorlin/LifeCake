class LivesController < ApplicationController
  
  before_action :login_required
  before_action :auto_with_date, only:[:create, :update]
  
  include SelectItems

  def index
    @lives = current_user.lives.all.order(:start_time)
    @time_sum_of_days = time_sum_of_days(@lives)
  end


  def time_sum_of_days(lives)
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

  def show
  end

  def edit
    @life = Life.find(params[:id])
  end

  def update
    @life = Life.find(params[:id])

    if @life.update_attributes(life_params)
      redirect_to lives_path
    else
      render :new
    end

  end

  def new
    @life = Life.new
  end

  def create

    @life = current_user.lives.new(life_params)

    if @life.save!
      redirect_to lives_path
    else
      render :new
    end

  end

  def destroy
    @life = Life.find(params[:id])
    @life.destroy

    redirect_to lives_path

  end

  private

  def auto_with_date
    if cookies["selected_date"]
      params["life"]["start_time"] = "#{cookies["selected_date"]} #{params["life"]["start_time"]}"  if params["life"]["start_time"].length <= 5 
      params["life"]["end_time"]   = "#{cookies["selected_date"]} #{params["life"]["end_time"]}"    if params["life"]["end_time"].length <= 5 
    end
  end


  def life_params
    params.require("life").permit("start_time", "end_time", "description", "location", "tags_all", "companion")
  end
end
