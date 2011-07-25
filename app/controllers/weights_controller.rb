class WeightsController < ApplicationController
  def index
    @today = Weight.today
    @recent_weights = Weight.recent
  end

  def update
    weight, date = massage_params
    Weight.update_weight(Date.parse(date), weight)
    redirect_to weights_path
  end

  def create
    update
  end

  private
  def massage_params
    [params[:weight][:weight].to_f, params[:weight][:date] || Date.today.to_s]
  end
end
