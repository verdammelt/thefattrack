Given /^that the previous trend weight was (\d+)$/ do |trend|
  Weight.new(:date => Date.today.prev_day, :trend => trend).save
end

Given /^I enter (\d+) as today's weight$/ do |weight|
  visit weights_path
  fill_in 'weight_weight', :with => weight
end

When /^I click Save$/ do
  click_button "Save"
end

Then /^I see that the Current Trend is (\d+)$/ do |trend|
  if page.respond_to? :should
    page.should have_content trend
  else
    assert page.has_content? trend
  end
end
