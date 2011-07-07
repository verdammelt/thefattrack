require 'spec_helper'

describe 'weights/index.html.erb' do
  let(:weight) { mock_model("Weight").as_null_object }

  before do
    assign :today, weight
    assign :recent_weights, []
  end

  it 'is ok when there is no data at all in the db' do
    weight.stub :weight => nil
    weight.stub :trend => nil
    render
  end

  it 'rounds trend to 2 decimal places' do
    weight.stub :trend => 190.005
    render
    trend_should_be "190.01"
  end

  it 'renders form to enter todays weight' do
    weight.stub :weight => 190.0
    weight.stub :date => Date.parse("2011-07-04")
    weight.stub :trend => 191.0

    render
    rendered.should have_selector "form", :method => "post", :action => weight_path(weight) do |form|
      date_should_be "2011-07-04", form
      weight_should_be "190.0", form
      trend_should_be "191.0", form
      form.should have_selector "input", :type => "submit"
    end
  end

  def date_should_be date, scope = rendered
    scope.should have_selector "label", :id => "weight_date" do |label|
      label.should contain date
    end
  end

  def weight_should_be weight, scope = rendered
    scope.should have_selector "input", :type => "text", :name => "weight[weight]", :value => "190.0"
  end

  def trend_should_be trend, scope = rendered
    scope.should have_selector "label", :id => "weight_trend" do |label|
      label.should contain(trend)
    end
  end

  it "renders a list of all weights" do
    specific_mock_weight = mock_model("Weight", :date => Date.new(1970, 9, 11), :weight=> 10, :trend => 9)
    weight.stub(:date => Date.new(2000,1,1), :weight => 100, :trend => 200)
    assign :recent_weights, [weight, specific_mock_weight]

    render

    rendered.should have_table "Recent Weights", :rows => [["2000-01-01", "100", "200.0"], ["1970-09-11", "10", "9.0"]]
  end

  it "rounds trend in list to 2 decimal places" do
    weight.stub(:date => Date.new(2000,1,1), :weight => 100, :trend => 100.005)
    assign :recent_weights, [weight]
    
    render

    rendered.should have_table "Recent Weights", :rows => [["2000-01-01", "100", "100.01"]]
  end
end
