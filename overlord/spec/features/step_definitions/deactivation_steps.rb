Given(/^the bomb is activated$/) do
	visit '/'
	fill_in("activation-code", :with => "1234")
	click_button("Activate")
end


