require 'timecop'

Given /^that today is (\d+)\-(\d+)\-(\d+)$/ do |year, month, day|
  Timecop.freeze(year.to_i, month.to_i, day.to_i)
end

Given /^that the previous trend weight was ([\d.]+)$/ do |trend|
  Weight.new(:date => Date.today-1, :trend => trend).save
end

Given /^that today's weight is (\d+)$/ do |weight|
  Weight.new(:date => Date.today, :weight => weight.to_f).save
end

Given /^that the following data exists$/ do |table|
  table.hashes.each { |data|
    Weight.create :date => Date.parse(data[:date]),
    :weight => data[:weight].to_f(),
    :trend => data[:trend].to_f() }
end

