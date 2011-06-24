require 'spec_helper'

describe 'weights/index.html.erb' do
  let(:weight) { mock_model("Weight").as_null_object }

  before do
     assign :today, weight
    assign :all_weights, []
  end

  it 'displays todays trend' do
    weight.stub :trend => 190.0

    render
    rendered.should contain("Trend: 190.0")
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
    assign :all_weights, [weight, specific_mock_weight]

    render

    rendered.should have_selector "table[name='all_weights_table']" do |table|
      table.should have_selector "tr:nth-of-type(2)" do |tr|
        tr.should have_selector "td", :content => "2000-01-01"
        tr.should have_selector "td", :content => "100"
        tr.should have_selector "td", :content => "200"
      end
      table.should have_selector "tr:nth-of-type(3)" do |tr|
        tr.should have_selector "td", :content => "1970-09-11"
        tr.should have_selector "td", :content => "10"
        tr.should have_selector "td", :content => "9"
      end
    end
  end
end
