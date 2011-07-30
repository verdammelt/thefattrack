require 'spec_helper'

describe 'layouts/application.html.erb' do
  before do
    view.stub(:setup_graph)
    view.stub(:render_graph)
  end

  it 'has the product name in the title' do
    render
    rendered.should have_selector 'title', :content => 'The Fat Track'
  end

  it "sets up the graph" do
    view.should_receive(:setup_graph).once
    view.should_receive(:render_graph).once
    render
  end
end
