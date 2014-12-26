require 'test_helper'

class RelationshipsControllerTest < ActionController::TestCase

def setup
  	@user = User.new(name: "Bill Guy", 
      email: "billguy@gmail.com", 
      password: "securepassword", id: 4)
    @user_two = User.new(name: "Bob Guy", 
      email: "bobguy@gmail.com", 
      password: "securepassword", id: 5)
    @user.save
    @user_two.save
    @relationship = Relationship.new(follower_id: @user,
     followed_id: @user_two, id: 1)
    @relationship.save
end


test "create should require signed_in user" do
	assert_no_difference "Relationship.count" do
		post :create
	end	
	assert_redirected_to new_user_session_url
end

test "destroy should require signed in user" do
	assert_no_difference "Relationship.count" do
		delete :destroy, id: @relationship
	end
	assert_redirected_to new_user_session_url
end


end