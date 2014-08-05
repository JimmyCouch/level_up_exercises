require_relative '../spec_helper'

describe 'Overlord', :type => :feature do

	before(:each) do
		visit '/'
	end

	it 'responds with successful status' do
		expect(page.status_code).to be 200
	end

	it "should have a field for an activation code" do
		expect(page).to have_selector('#activation-code')
	end

	it "should have an indicator of the bomb's state" do
		expect(page).to have_selector('#bomb-state')
	end

	it "should have a button to activate the bomb" do
		expect(page).to have_selector("#bomb-activate")
	end

end

describe 'when first booting the bomb', :type => :feature do

	before(:each) do
		visit '/'
		click_button('Activate')
	end

	it "The bomb should not be activated" do
		expect(page.find("#bomb-state")).to have_content("Inactive")		
	end

end



describe 'when activating the bomb', :type => :feature do

	before(:each) do
		visit '/'
		click_button('Activate')
	end

	describe 'when inputting non-numeric values', :type => :feature do 

		it "the result should be invalid" do
			fill_in 'Activation Code', :with => "ABCD"
			click_button 'Activate'
			expect(page).to have_content 'Error'	
		end

	end

	describe 'when inputting numeric values', :type => :feature do 

		before(:each) do
			fill_in 'Activation Code', :with => "1234"
			click_button 'Activate'
		end

		it "result is successful" do
			expect(page).to have_content 'Sucess'
		end

		it "the bomb should be active" do
			expect(page.find("#bomb-state")).to have_content("Activated")
		end

		it "re-entering the code should have no effect" do 
			fill_in 'Activation Code', :with => "1234"
			click_button 'Activate'
		end

	end


end


describe 'when deactivating the bomb', :type => :feature do

	before(:each) do
		visit '/'

	end

	describe 'when deactivating the bomb incorrectly', :type => :feature do 

		it "the result is unsuccessful when non-numeric values are entered" do
			fill_in 'Deactivation Code', :with => "ABCD"
			click_button 'Deactivate'
			expect(page).to have_content("Error")
		end

		it 'the bomb should explode on 3 unsuccessful attempts' do
			fill_in 'Deactivation Code', :with => "ABCD"
			click_button 'Deactivate'
			fill_in 'Deactivation Code', :with => "ABCD"
			click_button 'Deactivate'
			fill_in 'Deactivation Code', :with => "ABCD"
			click_button 'Deactivate'

			expect(page).to have_content "EXPODE"
		end

	end

	describe 'when deactivating the bomb correctly', :type => :feature do

		before(:each) do
			visit '/'
			fill_in 'Deactivation Code', :with => "0000"
			click_button 'Deactivate'
		end

		it "the result is successful" do
			expect(page).to have_content 'Sucess'
		end

		it "the bomb should be inactive" do
			expect(page.find("#bomb-state")).to have_content("Inactive")		
		end

	end

end

