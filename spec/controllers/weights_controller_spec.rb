require 'spec_helper'

describe WeightsController do
  let(:weight) { mock_model("Weight") }
  let(:recent_weights) { [mock_model("Weight", :date => Date.today), mock_model("Weight", :date => Date.today.next)]}
  
  before do
    Weight.stub(:today => weight)
    Weight.stub(:recent => recent_weights)
  end
  
  describe "GET index" do
    it "sets today" do
      get :index
      assigns[:today].should == weight
    end
    
    it "sets recent_weights what the model says is recent" do
      get :index
      assigns[:recent_weights].should == recent_weights
    end
  end
  
  describe "PUT create" do
    it "creates a weight" do
      today = Date.today
      Weight.should_receive(:update_weight).with(today, 190.5)
      put :create, :weight => { "weight" => "190.5", "date" => today.to_s }
    end
  end

  describe "PUT update" do
    it "sets the weight" do
      prev_day = Date.today - 1
      Weight.should_not_receive(:today)
      Weight.should_receive(:update_weight).with(prev_day, 190.5)
      put :update, :id => 1, :weight => { "weight" => "190.5", "date" => prev_day.to_s }
    end

    it "redirects to index page" do
      Weight.stub(:update_weight)
      put :update, :id => 1, :weight => {"weight" => "0"}
      response.should redirect_to(weights_path)
    end
  end
end
