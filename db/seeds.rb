# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
require 'date'

Weight.create(:date => Date.parse("2011-06-30"), :weight => 186.0, :trend => 184.44)
Weight.create(:date => Date.parse("2011-06-29"), :weight => 184.3, :trend => 184.27)
Weight.create(:date => Date.parse("2011-06-28"), :weight => 184.1, :trend => 184.26)
Weight.create(:date => Date.parse("2011-06-27"), :weight => 184.1, :trend => 184.28)
Weight.create(:date => Date.parse("2011-06-26"), :weight => 185.4, :trend => 184.3)
Weight.create(:date => Date.parse("2011-06-25"), :weight => 186.3, :trend => 184.18)
Weight.create(:date => Date.parse("2011-06-24"), :weight => 185.4, :trend => 183.94)
Weight.create(:date => Date.parse("2011-06-23"), :weight => 185.4, :trend => 183.78)
Weight.create(:date => Date.parse("2011-06-22"), :weight => 183.5, :trend => 183.6)
Weight.create(:date => Date.parse("2011-06-21"), :weight => 183.8, :trend => 183.61)
Weight.create(:date => Date.parse("2011-06-20"), :weight => 185.3, :trend => 183.59)
Weight.create(:date => Date.parse("2011-06-19"), :weight => 181.5, :trend => 183.4)
Weight.create(:date => Date.parse("2011-06-18"), :weight => 183.5, :trend => 183.61)
Weight.create(:date => Date.parse("2011-06-17"), :weight => 183.5, :trend => 183.62)
