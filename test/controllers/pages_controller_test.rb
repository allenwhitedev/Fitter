require "test_helper"

class PagesControllerTest < ActionController::TestCase

test "should get home" do
	get :home
	assert_response :success
	assert_select "title", "Home"	
end

test "should get other_sites" do
	get :other_sites
	assert_response :success
	assert_select "title", "Other_Sites"
end

test "should get about" do
	get :about
	assert_response :success
	assert_select "title", "About"
end



end