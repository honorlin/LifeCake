class LivesController < ApplicationController
  
  before_action :login_required
  before_action :auto_with_date, only:[:create, :update]
  
  include SelectItems

  def index
    @lives = current_user.lives.all.order(:start_time)
    @time_sum_of_days = LifeTimeSumOfDays.call(@lives)
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
    params.require("life").permit("start_time", "end_time", "description", "content", "location", "tags_all", "companion")
  end
end
