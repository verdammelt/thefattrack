require 'spec_helper'

describe WeightsController do
  let(:weight) { mock_model("Weight") }
  let(:all_weights) { [mock_model("Weight", :date => Date.today), mock_model("Weight", :date => Date.today.next_day)]}

  before do
    Weight.stub(:today => weight)
    Weight.stub(:find).with(:all).and_return(all_weights)
  end

  describe "GET index" do
    it "sets today" do
      get :index
      assigns[:today].should == weight
    end
    
    it "sets all_weights to reverse order" do
      get :index
      assigns[:all_weights].should == all_weights.reverse
    end
  end
end
