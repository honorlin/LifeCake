class LivesController < ApplicationController

  before_action :login_required

  def index
    @lives = current_user.lives.all
  end

  def show
  end

  def edit
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

  private

  def life_params
    params.require("life").permit("start_time", "end_time", "description", "location", "tags_all", "companion")
  end
end
