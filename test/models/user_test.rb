require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Test User", email:
    "test_user@example.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = " "
    assert_not @user.valid? # true if valid fails
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "x" * 31
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "x" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept    valid addresses" do
    valid_addresses = %w[test_user@example.com TEST_@EXAMPLE.COM test@KlK.gov.org
    H-I@inbox.lv]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be
      valid" # custom error message
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[test@example,com TEST.example.org
    test_user@example.
    foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect}
      should be invalid"
    end
  end

end
