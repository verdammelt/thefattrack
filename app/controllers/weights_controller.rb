class WeightsController < ApplicationController
  def index
    @today = Weight.today
    @recent_weights = Weight.recent
  end

  def update
    weight = params[:weight][:weight].to_f
    date = Date.parse(params[:weight][:date] || Date.today.to_s)

    Weight.update_weight(date, weight)

    redirect_to weights_path
  end

  def create
    update
  end
end
