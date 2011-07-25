Given /^I enter (\d+)\-(\d+)\-(\d+) as the date$/ do |year, month, day|
  fill_in "weight[date]", :with => "#{year}-#{month}-#{day}"
end

Given /^I enter ([\d.]+) as the weight$/ do |weight|
  enter_the_weight weight
end

Given /^I enter ([\d.]+) as today's weight$/ do |weight|
  enter_the_weight weight
end

When /^I click Save$/ do
  click_button "Save"
end

def enter_the_weight weight
  fill_in "weight[weight]", :with => weight
end
