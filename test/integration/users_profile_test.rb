require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
	include ApplicationHelper
 
  def setup
  	@user = users(:first_guy)
  	#@user = User.new(name: "Guy Name", 
  	#	email: "guyname@", 
  	#	encrypted_password: "secretpassword")
  end

  test "valid_fixture" do
  	assert @user.valid?
  end

  test "profile display" do
  	get user_path(@user)
  	assert_response :success
  # 	#assert_template 'users/show'
   end
  
end
