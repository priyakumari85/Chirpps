require 'test_helper'

class UserloginsControllerTest < ActionController::TestCase

  test 'new assigns user login and renders new page' do
	 get :new

	 assert_not_nil assigns(:user_login)
	 assert_response :success
	 assert_template :new
  end

  test 'create initializes error variable' do
	 post :create, :username => 'jaky', :password => 'Abcde@123'

	 assert_equal assigns(:errors).class, Hash
  end


  test 'create initializes session variable' do
	 post :create, :username => 'jaky', :password => 'Abcde@123'

	 assert_equal session[:current_user_id],1
  end

  test 'create redirects to chirrps index' do
	 post :create, :username => 'jaky', :password => 'Abcde@123'

	 assert_response 302
     assert_redirected_to '/chirpps'
  end

  test 'create with empty wrong user name redirects to create_error' do
   xhr :post, :create, :username => 'aaaa', :password => ''

   assert_response :success
   assert_template :create_error
  end


  test 'create with empty username and password redirects to create_error' do
	 xhr :post, :create, :username => '', :password => ''

	 assert_response :success
   assert_template :create_error
  end

  test 'create renders error when password mistach happens' do
	 xhr :post, :create, :username => 'jaky', :password => 'aaaa'

	 assert_response :success
     assert_template :create_error
  end

  test 'logout clears session variable' do
	get :logout

	 assert_equal session[:current_user_id],""
  end

  test 'logout redirsts to chirpps show' do
	get :logout

	 assert_response 302
     assert_redirected_to '/'
  end

end
