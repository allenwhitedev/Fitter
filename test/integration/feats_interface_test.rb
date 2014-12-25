require "test_helper"

class FeatsInterfaceTest < ActionDispatch::IntegrationTest

def setup
	@user = User.new(name: "Test Guy1", email:
		"testguy1@gmail.com", encrypted_password: 
		"secretpassword")
end	



end