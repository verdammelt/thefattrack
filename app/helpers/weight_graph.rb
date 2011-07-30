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

      chart.add_rows(data.collect { |w| [w.date, w.weight, w.trend] })
    end
  end
end
