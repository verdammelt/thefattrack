include ActionView::Helpers::TagHelper
module WeightGraph
  include GoogleVisualization

  def setup_graph
    include_visualization_api
  end

  def render_graph
    render_visualizations
  end

  def insert_graph data
    visualization 'fatgraph', 'LineChart' do |chart|
      chart.date 'Day'
      chart.number 'Weight'
      chart.number 'Trend'

      chart.add_rows(data.collect { |w| make_row_data w } )
    end
  end

  private
  def make_row_data w
    trend = (w.trend*100).round/100.0 unless w.trend.nil?
    [w.date, w.weight, trend] 
  end
end
