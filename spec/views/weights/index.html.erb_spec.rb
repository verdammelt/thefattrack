require 'spec_helper'

describe 'weights/index.html.erb' do
  let(:weight) { mock_model("Weight").as_null_object }

  before do
     assign :today, weight
    assign :recent_weights, []
  end

  it 'displays todays trend' do
    weight.stub :trend => 190.0

    render
    rendered.should contain("Trend: 190.0")
  end

  it 'rounds trend to 2 decimal places' do
    weight.stub :trend => 190.005

    render
    rendered.should contain("Trend: 190.01")
  end

  it 'renders form to enter todays weight' do
    weight.stub :weight => 190.0

    render
    rendered.should have_selector "form", :method => "post", :action => weight_path(weight) do |form|
      form.should have_selector "input", :type => "text", :name => "weight[weight]", :value => "190.0"
      form.should have_selector "input", :type => "submit"
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
