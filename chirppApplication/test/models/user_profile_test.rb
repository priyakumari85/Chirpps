require 'test_helper'

class UserProfileTest < ActiveSupport::TestCase
  setup do
    @user = UserProfile.new(first: 'John', last: 'Doe', email: 'jdoe2@email.com', phone: 4049746590, addline1: 'west aiprt blvd', addline2: '', street: 'Street1', city: 'SugarLand', country: 'USA', pincode: '77498')
  end

  test 'canary test should pass' do
    assert true
  end

  test 'user is valid' do
    assert @user.valid?
  end 

  test 'first name is required' do
    @user.first = ""
    assert !@user.valid?
    assert_equal ["can't be blank"], @user.errors[:first]
  end

  test 'last name is required' do
    @user.last = ""
    assert !@user.valid?
    assert_equal ["can't be blank"], @user.errors[:last]
  end

  test 'email address is required' do
    @user.email = ""
    assert !@user.valid?
    assert_equal ["can't be blank", "is invalid"], @user.errors[:email]
  end

  test 'phone is optional' do
    @user.phone = ""
    assert @user.valid?
  end

  test 'two user cannot have same email address' do
    @user.email = user_profiles(:one).email
    assert !@user.valid?
    assert_equal ["has already been taken"], @user.errors[:email]
  end

  test 'user email should follow pattern' do
    @user.email = 'dddd'
    assert !@user.valid?
    assert_equal ["is invalid"], @user.errors[:email]
  end

  test 'phone number cannot be less than 10 digit' do
    @user.phone = 1234
    assert !@user.valid?
    assert_equal ["is invalid"], @user.errors[:phone]
  end

end
