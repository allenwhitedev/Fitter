require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

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
    assert_difference "Feat.count", -1 do
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


end
