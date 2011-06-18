class WeightsController < ApplicationController
  def index
    @today = Weight.today
  end

  def update
    @today = Weight.today
    @today.weight = params[:weight][:weight].to_f
    @today.save
    redirect_to weights_path
  end
end
