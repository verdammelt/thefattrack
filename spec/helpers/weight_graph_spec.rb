require 'spec_helper'

class View
  include WeightGraph
end

describe "WeightGraph" do
  let(:view) { View.new }

  it "setup_graph calls includes_visualization_api" do
    view.should_receive(:include_visualization_api).once
    view.setup_graph
  end

  it "render_graph calls render_visualizations" do
    view.should_receive(:render_visualizations).once
    view.render_graph
  end

  it "insert calls visualization" do
    view.should_receive(:visualization).once
    view.insert_graph []
  end

  context "graph creation details " do
    it "graph id is fatgraph" do
      view.should_receive(:visualization).with('fatgraph', anything())
      view.insert_graph []
    end

    it "graph type is LineChart" do
      view.should_receive(:visualization).with(anything, 'LineChart')
      view.insert_graph []
    end

    it "sets up 3 columns" do
      chart = mock.as_null_object
      view.should_receive(:visualization).and_yield(chart)
      chart.should_receive(:date).with('Day')
      chart.should_receive(:number).with('Weight')
      chart.should_receive(:number).with('Trend')
      view.insert_graph []
    end

    it "adds the weight data as rows correctly" do
      weight1 = Weight.new(:date => Date.parse('2001-01-01'), :weight => 100, :trend => 101)
      weight2 = Weight.new(:date => Date.parse('2001-01-01'), :weight => 102, :trend => 103)

      chart = mock.as_null_object
      view.should_receive(:visualization).and_yield(chart)
      chart.should_receive(:add_rows).with([[weight1.date, weight1.weight, weight1.trend],
                                           [weight2.date, weight2.weight, weight2.trend]])

      view.insert_graph [weight1, weight2]
    end

    it "rounds the trend to 2 digits before passing to the charting" do
      weight = Weight.new(:date => Date.parse('2001-01-01'), :weight => 100, :trend => 3.14159)
      chart = mock.as_null_object
      view.should_receive(:visualization).and_yield(chart)
      chart.should_receive(:add_rows).with([[weight.date, weight.weight, 3.14]])

      view.insert_graph [weight]
    end
  end
end
