require 'test_helper'

class FeatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = users(:first_guy)
  	@feat = @user.feats.build(content: "Valid content is here.")
  end

  test "should be valid" do
  	assert @feat.valid?
  end

  test "should have user_id as foreign key" do
  	@feat.user_id = nil
  	assert_not @feat.valid?
  end

  test "8 <= # of content characters <= 1000 characters" do
  	@feat.content = "   "
  	assert_not @feat.valid?
  	@feat.content = "L" * 1001
  	assert_not @feat.valid?
  	@feat.content = "eight"
  	assert_not @feat.valid?
  	@feat.content = "B" * 800
  	assert @feat.valid?
  end

  test "order should be descending from most recently created" do
    assert_equal Feat.first, feats(:most_recent)
  end

end
