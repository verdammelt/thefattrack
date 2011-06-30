require 'spec_helper'

describe Weight do
  describe "#today" do
    it "finds todays weight if it exists" do
      Weight.create :date => Date.today, :weight => 500
      
      today = Weight.today
      today.date.should == Date.today
      today.weight.should == 500
    end
    
    it "initializes (but not creates) a new weight for today if needed" do
      today = Weight.today
      today.new_record?.should be_true
      today.date.should == Date.today
      today.weight.should be_nil
      Weight.find_by_date(Date.today).should be_nil
    end
    
    it "trend set to latest trend weight" do
      Weight.create :date => Date.today.prev_day, :trend => 500
      Weight.today.trend.should == 500
    end
  end

  context "#weight=" do 
    it "calculates trend when weight is set" do
      Weight.create(:date => Date.today.prev_day, :trend => 190)
      w = Weight.new(:date => Date.today, :weight => 190)
      w.weight = 200
      w.trend.should == 191
    end
  end

  context "trend" do
    it "defaults to weight" do
      Weight.new(:weight => 190).trend.should == 190
    end
  end

  context "trend calculation" do
    it "always calculates based upon old trend" do
      Weight.create :date => Date.today.prev_day, :trend => 200
      w = Weight.create :date => Date.today, :weight => 190, :trend => 199
      w.weight = 190
      w.trend.should == 199
    end
    
    it "handles nil ok" do
      w = Weight.new(:weight => 100)
      w.weight = 90
      w.trend.should == 90
    end
  end
end
