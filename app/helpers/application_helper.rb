module WeightGraph
  include GoogleVisualization

  def weight_chart_setup
    include_visualization_api
  end

  def render_chart
    render_visualizations
  end

  def weight_chart data
    visualization "fattrack", "LineChart", :html => {:class => "graph_chart"} do |chart| 
      chart.date 'Day'
      chart.number 'Weight'
      chart.number 'Trend'

      chart.add_rows((@recent_weights.reverse << @today).collect { |w| [w.date, w.weight, round_for_display(w.trend)]}) 
    end
  end
end

module ApplicationHelper
  include WeightGraph

  def round_for_display f
    return f.round(2) unless f.nil?
    nil
  end
end

