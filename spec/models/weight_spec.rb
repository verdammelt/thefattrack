require 'spec_helper'

describe Weight do
  it "creates todays weight if needed" do
    today = Weight.find_or_create_by_date Date.today
    today.date.should == Date.today
    today.weight.should be_nil
    Weight.find_by_date(Date.today).should_not be_nil
  end

  it "finds todays weight" do
    w = Weight.new(:date => Date.today)
    w.weight = 500
    w.save

    today = Weight.find_or_create_by_date Date.today
    today.date.should == Date.today
    today.weight.should == 500
  end

  it "calculates trend when weight is set" do
    Weight.create(:date => Date.today.prev_day, :trend => 190)
    w = Weight.new(:date => Date.today, :weight => 190)
    w.weight = 200
    w.trend.should == 191
  end

  it "trend defaults to previous trend weight" do
    Weight.create :date => Date.today.prev_day, :trend => 500
    Weight.today.trend.should == 500
  end

  it "trend defaults to weight" do
    Weight.new(:weight => 190).trend.should == 190
  end

  it "always calculates new trend based upon old trend" do
    Weight.create :date => Date.today.prev_day, :trend => 200
    w = Weight.create :date => Date.today, :weight => 190, :trend => 199
    w.weight = 190
    w.trend.should == 199
  end

  it "trend calculation handles nil ok" do
    w = Weight.new(:weight => 100)
    w.weight = 90
    w.trend.should == 90
  end
end
