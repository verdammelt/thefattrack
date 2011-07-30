include ActionView::Helpers::TagHelper
class WeightGraph
  def self.initialize
  end

  def self.insert_graph
    tag 'div', {:id => 'fatgraph'}
  end
end
