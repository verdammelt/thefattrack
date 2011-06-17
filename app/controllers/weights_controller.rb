class WeightsController < ApplicationController
  def index
    @todays_weight = Weight.find_or_create_by_date(Date.today) do |w|
      w.trend = latest_trend
    end
    @todays_weight.trend = @todays_weight.weight if @todays_weight.trend.nil?
  end

  def update
    @todays_weight = Weight.find(params[:id])
    @todays_weight.weight = params[:weight][:weight]
    @todays_weight.trend = calculate_trend @todays_weight.trend, @todays_weight.weight
    @todays_weight.save
    redirect_to weights_path
  end

  def calculate_trend trend, weight
    return weight if (trend.nil? || trend == 0.0)

    trend - ((trend - weight) * 0.1)
  end

  def latest_trend
    latest_weight = Weight.order("date desc").first
    return nil if latest_weight.nil?

    latest_weight.trend
  end
end
