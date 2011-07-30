Then /^I see a Fat Track Graph$/ do
  find_by_id("fatgraph").should_not be_nil
end

