require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
	include ApplicationHelper
 
  def setup
  	@user = users(:first_guy)
  end

  test "valid_fixture" do
  	assert @user.valid?
  end

  test "profile display" do
  	# get user_path(@user)
  	# assert_response :success
  # 	#assert_template 'users/show'
   end
  
end
