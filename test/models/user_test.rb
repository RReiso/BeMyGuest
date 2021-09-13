require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user =
      User.new(
        name: 'Test User',
        email: 'test_user@example.com',
        password: '1234abcd',
        password_confirmation: '1234abcd',
        terms_and_conditions: '1'
      )
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = ' '
    assert_not @user.valid? # true if valid fails
  end

  test 'email should be present' do
    @user.email = ' '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'x' * 31
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'x' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[
      test_user@example.com
      TEST_@EXAMPLE.COM
      test@KlK.gov.org
      H-I@inbox.lv
    ]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?,
             "#{valid_address.inspect} should be
      valid" # custom error message
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[
      test@example,com
      TEST.example.org
      test_user@example.
      foo@bar..com
      foo@bar+baz.com
    ]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?,
                 "#{invalid_address.inspect}
      should be invalid"
    end
  end

  test 'email addresses should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'password should be present (nonblank)' do
    @user.password = @user.password_confirmation = ' ' * 8
    assert_not @user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'x' * 7
    assert_not @user.valid?
  end

  test 'terms_and_conditions should be accepted' do
    @user.terms_and_conditions = ' '
    assert_not @user.valid?
  end

  test 'authenticated? should return false for a user with nil
digest' do
    assert_not @user.authenticated?('')
  end
end
