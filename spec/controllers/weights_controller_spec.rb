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

  describe "PUT update" do
    it "sets today's weight" do
      weight.as_null_object
      weight.stub(:date).and_return(Date.today.prev_day)
      Weight.should_receive(:today)
      weight.should_recieve(:save).with(:weight => 190.5, :date => Date.today.prev_day)
      put :update, :id => 1, :weight => { "weight" => "190.5" }
    end

    it "redirects to index page" do
      weight.as_null_object
      put :update, :id => 1, :weight => {"weight" => "0"}
      response.should redirect_to(weights_path)
    end
  end
end
