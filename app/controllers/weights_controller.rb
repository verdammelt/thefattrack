class WeightsController < ApplicationController
  def index
    @today = Weight.today
    @recent_weights = Weight.recent
  end

  def update
    new_weight = params[:weight][:weight].to_f
    new_date = params[:weight][:date] || Date.today.to_s
    Weight.update_weight(Date.parse(new_date), new_weight)
    redirect_to weights_path
  end

  def create
    update
  end
end
