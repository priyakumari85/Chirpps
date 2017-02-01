require 'test_helper'

class UserloginNewTest < ActionDispatch::IntegrationTest

  test 'User Login page should have form to input username and password' do
    get '/userlogins/new'

    assert_response :success

    assert_select "form input[type=text][id=username]"
    assert_select "form input[type=password][id=password]"
    assert_select "form input[type=submit][value='Login']"
  end
end
