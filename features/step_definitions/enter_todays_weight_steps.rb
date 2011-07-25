Given /^that the previous trend weight was ([\d.]+)$/ do |trend|
  Weight.new(:date => Date.today.prev_day, :trend => trend).save
end

Given /^I enter ([\d.]+) as today's weight$/ do |weight|
  fill_in "weight[weight]", :with => weight
end

Given /^that today's weight is (\d+)$/ do |weight|
  Weight.new(:date => Date.today, :weight => weight.to_f).save
end

When /^I click Save$/ do
  click_button "Save"
end

Then /^I see that the Current Trend is ([\d.]+)$/ do |trend|
  label = find_by_id :weight_trend
  label.text.should =~ /^#{trend}/
end

Then /^I see that today's weight is (\d+)$/ do |weight|
  field = find_by_id :weight_weight
  field.value.should =~ /#{weight}/
end
