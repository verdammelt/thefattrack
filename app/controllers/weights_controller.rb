require 'googlecharts'
class WeightsController < ApplicationController
  def index
    @today = Weight.today
    @recent_weights = Weight.recent

    chart_weight = ([@today] + @recent_weights).reverse.take(30)

    @chart_url = Gchart.line(:size => "400x600",
                             :title => "Your Fat Track",
                             :legend => ['weights', 'trend'],
                             :line_colors => "FF0000,00FF00",
                             :axis_with_labels => 'y',
                             :encoding => 'text',
                             :min_value => 'auto',
                             #:axis_labels => [chart_weight.collect { |w| w.date }, chart_weight.collect { |w| w.weight} ],
                             :data => [chart_weight.collect{|w| w.weight}, chart_weight.collect{|w| w.trend}])

  end

  #http://chart.apis.google.com/chart?chxt=y&chco=FF0000,00FF00&chd=t:183.5,183.5,181.5,185.3,183.8,183.5,185.4,185.4,186.3,185.4,184.1,184.1,184.3,186.0,186.0,186.3,185.4,185.5,187.1,186.1,185.8,187.2,187.1,187.1,180.6,183.6,185.2,184.6,183.3,184.0|183.62,183.61,183.4,183.59,183.611,183.5999,183.77991,183.941919,184.17772710000003,184.29995439000004,184.27995895100003,184.26196305590005,184.26576675031004,184.43919007527904,184.59527106775113,184.765743960976,184.8291695648784,184.89625260839057,185.1166273475515,185.21496461279636,185.2734681515167,185.46612133636503,185.62950920272857,185.7765582824557,185.25890245421013,185.0930122087891,185.1037109879102,185.05333988911917,184.87800590020728,184.79020531018656&chds=180.6,187.2&chdl=weights|trend&chtt=Your+Fat+Track&cht=lc&chs=400x600&chxr=0,auto,187.2|1,auto,185.7765582824557

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
