require "test_helper"

class UsersControllerTest < ActionController::TestCase

	test "should get new user page" do
		get :new
		assert_response :success
	end

end