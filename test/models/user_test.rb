require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup

    # Users
  	@user = User.new(name: "Bill Guy", 
      email: "billguy@gmail.com", 
      password: "securepassword", id: 4)
    @user_two = User.new(name: "Bob Guy", 
      email: "bobguy@gmail.com", 
      password: "securepassword", id: 5)
     @user_three = User.new(name: "Brad Guy", 
      email: "bradguy@gmail.com", 
      password: "securepassword", id: 6)
    @user.save
    @user_two.save
    @user_three.save

    # Feats
    @feat = @user.feats.create(content: "1Valid content is here.")
    @feat1 = @user.feats.create(content: "2 Valid content is here.")
    @feat2 = @user_two.feats.create(content: "1 Valid content is here.")
    @feat3 = @user_two.feats.create(content: "2 Valid content is here.")
    @feat4 = @user_two.feats.create(content: "3 Valid content is here.")
    @feat5 = @user_three.feats.create(content: "1 Valid content is here.")
    @feat6 = @user_three.feats.create(content: "2 Valid content is here.")
    @feat7 = @user_three.feats.create(content: "3 Valid content is here.")
    @feat8 = @user_three.feats.create(content: "4 Valid content is here.")
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "name should be valid" do
  	@user.name = ""
  	assert_not @user.valid?
  end

   test "email should be valid" do
  	@user.email = ""
  	assert_not @user.valid?
  end

  test "1 < # of name characters <= 50" do
  	@user.name = "a" * 51
  	assert_not @user.valid?
  	@user.name = "a"
  	assert_not @user.valid?
  end

  test "1 < # of email characters <= 75" do
  	@user.name = "b" * 76
  	assert_not @user.valid?
  	@user.name = "b"
  	assert_not @user.valid?
	end

	test "email should accept valid email regex form" do
		valid_addresses = %w[legitimate@gmail.com EMAILGUY@gmail.COM
		 G_US-FA@gmail.yahoo.org bill.white@gmail.yahoo 
		 maryvi+phil@real.ca]
		valid_addresses.each do |valid_address|
			@user.email = valid_address
			assert @user.valid?, "#{valid_address.inspect} should be 
			valid"
		end
	end

	test "email should reject invalid regex form" do
		invalid_addresses = %w[notperiod@hotmail,com no_at_sym.net 
			periods.here@yahoo.gmail@hotm_ail.com sym@bol+inp.org]
		invalid_addresses.each do |invalid_address|
			@user.email = invalid_address
			assert_not @user.valid?, "#{invalid_address.inspect} 
			should be invalid"
		end
	end

	test "emails should be unique" do
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
		assert_not duplicate_user.valid?
	end

  test "a user's feats should be destroyed when they are" do
    @user.save
    @user.feats.create!(content: "Valid content stuff")
    assert_difference "Feat.count", -@user.feats.count do
      @user.destroy
    end
  end

  test "should follow and unfollow" do
    assert_not @user.following?(@user_two)
    @user.follow(@user_two)
    assert @user_two.followers.include?(@user)
    assert @user.following?(@user_two)
    @user.unfollow(@user_two)
    assert_not @user.following?(@user_two)
    assert_not @user_two.followers.include?(@user)
  end

  test "feed should have posts of user and following only" do
   
    # Following posts
    @user_three.feats.each do |followed_feat|
      @user.feed.include?(followed_feat)
    end
    # User's own posts
    @user.feats.each do |own_feat| 
      assert @user.feed.include?(own_feat)
    end
    # Non-following posts 
    @user_two.feats.each do |non_feat|
      assert_not @user.feed.include?(non_feat)
    end
  end    


end
