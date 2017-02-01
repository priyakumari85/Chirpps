require 'test_helper'

class UserLoginTest < ActiveSupport::TestCase
  setup do
    @userlogin = UserLogin.new(username: 'johnnydepp', password: 'Abcde@123')
  end

	 test 'userlogin is valid' do
    assert @userlogin.valid?
  end 

  test 'username is required' do
    @userlogin.username = ""
    assert !@userlogin.valid?
    assert_equal ["can't be blank"], @userlogin.errors[:username]
  end

  test 'password is required' do
    @userlogin.password = ""
    assert !@userlogin.valid?
    assert_equal ["can't be blank", "must be at least 6 characters and include one number and one uppercase and lowercase letter and special characters @#$%^."], @userlogin.errors[:password]
  end

  test 'two user cannot have same username ' do
    @userlogin.username = user_logins(:one).username
    assert !@userlogin.valid?
    assert_equal ["has already been taken"], @userlogin.errors[:username]
  end

  test 'password must be at least 6 characters and include one number and one uppercase and lowercase letter and special characters @#$%^.' do
    @userlogin.password = 'Abcde123'
    assert !@userlogin.valid?
    assert_equal ["must be at least 6 characters and include one number and one uppercase and lowercase letter and special characters @#$%^."], @userlogin.errors[:password]
  end

end
