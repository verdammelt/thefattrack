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
      Weight.create :date => Date.today-1, :trend => 500
      Weight.today.trend.should == 500
    end
  end

  context "#weight=" do 
    it "calculates trend when weight is set" do
      Weight.create(:date => Date.today-1, :trend => 190)
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
      Weight.create :date => Date.today-1, :trend => 200
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

  context "recent weights" do
    it "they are in order by date (newest first)" do
      Weight.create :date => Date.today-1
      Weight.create :date => Date.today
      Weight.create :date => Date.today-2
      Weight.create :date => Date.today+1

      Weight.recent.collect {|d| d.date }.should ==
        [Date.today+1, Date.today-1, Date.today-2]
    end
  end

  context "#update_weight" do
    it "saves a new weight" do
      expected_date = Date.parse("2001-01-01")
      Weight.update_weight(expected_date, 190)
      Weight.find_by_date(expected_date).should_not be_nil
    end

    it "updates an existing weight" do
      expected_date = Date.parse("2001-01-01")
      Weight.create :date => expected_date, :weight => 100, :trend => 100
      Weight.update_weight(expected_date, 190)
      Weight.find_by_date(expected_date).weight.should == 190
      Weight.find_by_date(expected_date).trend.should == 190
    end

    it "sets trend on saved weight correctly" do
      Weight.create :date => Date.today-1-1, :weight => 190, :trend => 190
      Weight.create :date => Date.today-1, :weight => 190, :trend => 190

      Weight.update_weight Date.today-1, 189

      Weight.find_by_date(Date.today-1).trend.should == 189.9
    end

    it "updates all trends newer than saved weight" do
      Weight.create :date => Date.today-1, :weight => 190, :trend => 190
      Weight.create :date => Date.today, :weight => 189, :trend => 189.9

      Weight.update_weight(Date.today-1, 189)

      Weight.find_by_date(Date.today).trend.should == 189
    end
  end
end
