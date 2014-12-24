require "test_helper"

class FeatsControllerTest < ActionController::TestCase

def setup
	@feat = feats(:bench_press)
end

test "should redirect create when signed out" do
	assert_no_difference "Feat.count" do
		post :create, feat: { content: "Shouldn't be 
			made." }
	end
	assert_redirected_to new_user_session_url
end

test "should redirect destroy when signed out" do
	assert_no_difference "Feat.count" do
		delete :destroy, id: @feat
	end
	assert_redirected_to new_user_session_url
end	


# NO WAY TO CREATE FEATS YET
# test "should create when signed in" do
# 	assert_difference "Feat.count" do
# 		post :create, feat: { content: "Should 
# 			be created." }
# 	end
# end


end