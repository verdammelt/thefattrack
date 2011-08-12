include ActionView::Helpers::TagHelper

module WeightGraph
  include GoogleVisualization
  include Round

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
    trend = round_for_display w.trend
    [w.date, w.weight, trend] 
  end
end
