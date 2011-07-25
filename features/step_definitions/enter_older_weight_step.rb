require 'timecop'

Given /^I enter (\d+)\-(\d+)\-(\d+) as the date$/ do |year, month, day|
  fill_in "weight[date]", :with => "#{year}-#{month}-#{day}"
end

Given /^I enter ([\d.]+) as the weight$/ do |weight|
  fill_in "weight[weight]", :with => weight
end

Given /^that today is (\d+)\-(\d+)\-(\d+)$/ do |year, month, day|
  Timecop.freeze(year.to_i, month.to_i, day.to_i)
end

Then /^I see that the date field is (\d+)\-(\d+)\-(\d+)$/ do |year, month, day|
  field = find_by_id :weight_date
  field.value.should =~ /#{year}-#{month}-#{day}/
end
