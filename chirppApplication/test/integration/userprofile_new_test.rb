require 'test_helper'

class UserprofileNewTest < ActionDispatch::IntegrationTest

  test 'User Profile page should have labels' do
    get '/userprofiles/new'

    assert_response :success
    assert response.body.include? 'Sign Up'
    assert response.body.include? 'User Name*'
    assert response.body.include? 'Password*'
    assert response.body.include? 'First Name*'
    assert response.body.include? 'Last Name*'
    assert response.body.include? 'Email*'
    assert response.body.include? 'Phone'
  end

  test 'User Profile page should have form to input values' do
    get '/userprofiles/new'

    assert_response :success

    assert_select "form input[type=text][id=username]"
    assert_select "form input[type=password][id=password]"
    assert_select "form input[type=text][id=user_profile_first]"
    assert_select "form input[type=text][id=user_profile_last]"
    assert_select "form input[type=text][id=user_profile_email]"
    assert_select "form input[type=text][id=user_profile_phone]"
    assert_select "form input[type=submit][value='Signup']"
  end

end
