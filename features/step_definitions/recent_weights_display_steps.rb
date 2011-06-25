Given /^that the following data exists$/ do |table|
  table.hashes.each { |data|
    Weight.create :date => Date.parse(data[:date]),
    :weight => data[:weight].to_f(),
    :trend => data[:trend].to_f() }
end

When /^I view the index page$/ do
  visit weights_path
end

Then /^the Recent Weights table will show$/ do |expected|
  expected.diff!(actual_recent_weights_table)
end

def actual_recent_weights_table
  table = tableish('table#recent_weights tr', 'td,th')
  table.delete_at(1)
  table
end
