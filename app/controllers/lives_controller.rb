class LivesController < ApplicationController
  include SelectItems

  before_action :login_required
  


  def index
    @lives = current_user.lives.all.order(:start_time)
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



  def life_params
    params.require("life").permit("start_time", "end_time", "description", "location", "tags_all", "companion")
  end
end
