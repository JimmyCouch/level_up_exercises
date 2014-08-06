
Given(/^I visit the root page$/) do
	visit '/'
end

Given(/^I fill in '(.*)' for '(.*)'$/) do |value,field|
	fill_in(field, :with => value)
end

When(/^I press '(.*)'$/) do |button|
	click_button(button)
end

Then(/^I should see '(.*)'$/) do |response|
	body.should match(/#{response}/m)
end