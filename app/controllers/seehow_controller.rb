class SeehowController < ApplicationController
  include SelectItems

  def index
    if params["location"].present?
      @lives = current_user.lives.where("location like ?", "%#{params[:location]}%")
    elsif params["tags"].present?
      @lives = Tag.where(name: params["tags"]).first.lives
    elsif params["companion"].present?
      @lives = Companion.where(name: params["companion"]).first.lives
    else
      @lives = current_user.lives
    end
  end


end
