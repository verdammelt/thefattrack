require 'spec_helper'

describe WeightsController do
  let(:weight) { mock_model("Weight") }
  let(:recent_weights) { [mock_model("Weight", :date => Date.today), mock_model("Weight", :date => Date.today.next_day)]}

  before do
    Weight.stub(:today => weight)
    Weight.stub(:find).with(:all).and_return(recent_weights)
  end

  describe "GET index" do
    it "sets today" do
      get :index
      assigns[:today].should == weight
    end
    
    it "sets recent_weights to reverse order" do
      get :index
      assigns[:recent_weights].should == recent_weights.reverse
    end
  end
end
