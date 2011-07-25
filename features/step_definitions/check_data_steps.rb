Then /^I see that the date field is (\d+)\-(\d+)\-(\d+)$/ do |year, month, day|
  field = find_by_id :weight_date
  field.value.should =~ /#{year}-#{month}-#{day}/
end

Then /^I see that the Current Trend is ([\d.]+)$/ do |trend|
  label = find_by_id :weight_trend
  label.text.should =~ /^#{trend}/
end

Then /^I see that today's weight is (\d+)$/ do |weight|
  field = find_by_id :weight_weight
  field.value.should =~ /#{weight}/
end

Then /^the Recent Weights table will show$/ do |expected|
  expected.diff!(actual_recent_weights_table)
end

def actual_recent_weights_table
  table = tableish('table#recent_weights tr', 'td,th')
  table
end
