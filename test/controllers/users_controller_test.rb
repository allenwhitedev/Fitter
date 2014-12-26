require "test_helper"

class UsersControllerTest < ActionController::TestCase

  def setup
  	@user = User.new(name: "Bill Guy", 
      email: "billguy@gmail.com", 
      password: "securepassword", id: 4)
    @user_two = User.new(name: "Bob Guy", 
      email: "bobguy@gmail.com", 
      password: "securepassword", id: 5)
    @user.save
    @user_two.save
  end

  test "should redirect following and followers 
  if not signed in" do
  	get :following, id: @user
  	assert_redirected_to new_user_session_url
  	get :followers, id: @user
  	assert_redirected_to new_user_session_url
  end

	# test "should get new user page" do
	# 	get :new
	# 	assert_response :success
	# end



end